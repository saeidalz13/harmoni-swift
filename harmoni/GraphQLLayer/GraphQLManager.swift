//
//  GraphQLManager.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-01.
//
import Foundation

struct GraphQLRequest<T: Codable>: Codable {
    let query: String
    let variables: T?
}


final class GraphQLManager: Sendable {
    static let shared = GraphQLManager()
    private init() {}
    
    let maxRetry = 2

    func execOperation<T: Codable, U: Codable>(_ operation: GraphQLOperation, variables: T? = nil, withBearer: Bool) async throws -> U {
        let graphQLRequest = GraphQLRequest(
            query: operation.string,
            variables: variables
        )
        
        let httpReqBody = try DataSerializer.encodeJSON(value: graphQLRequest)
        
        var retry = true
        var attempts = 0
        var httpResp: Data? = nil
        while retry && attempts < maxRetry {
            do {
                httpResp = try await NetworkManager.shared.makeHTTPPostRequest(httpBody: httpReqBody, withBearer: withBearer)
                retry = false
                
            } catch NetworkError.expiredAccessToken {
                do {
                    try await renewAccessToken()
                    continue
                } catch {
                    throw error
                }
                
            } catch NetworkError.unprocessableEntity {
                print(try DataSerializer.dataToText(data: httpReqBody))
                throw NetworkError.unprocessableEntity
                
            } catch {
                attempts += 1
                
                if attempts >= maxRetry {
                    throw error
                }
                sleep(1)
                continue
            }
        }
        
        let gqlPayload = try DataSerializer.decodeJSON(data: httpResp!) as GraphQLRespPayload<U>
        
        if let errors = gqlPayload.errors {
            print(errors)
            throw GraphQLError.mutation(error: errors)
        }
        
        guard let gqlData = gqlPayload.data else {
            throw GraphQLError.unavailableData(queryName: operation.name)
        }
        
        return gqlData
    }
    
    func renewAccessToken() async throws {
        guard let refreshToken = KeychainManager.shared.retrieveFromKeychain(key: KeychainKey.refreshToken) else {
            throw SecurityError.unavailableToken
        }
        
        let graphQLRequest = GraphQLRequest(
            query: GraphQLOperationBuilder.renewAccessToken.build().string,
            variables: ["renewAccessTokenInput": RenewAccessTokenInput(refreshToken: refreshToken)]
        )
        
        let httpReqBody = try DataSerializer.encodeJSON(value: graphQLRequest)
        
        var httpResp: Data? = nil
        var retry = true
        var attempts = 0
        
        while retry && attempts < maxRetry {
            do {
                httpResp = try await NetworkManager.shared.makeHTTPPostRequest(httpBody: httpReqBody, withBearer: false)
                retry = false
            } catch {
                attempts += 1
                if attempts >= maxRetry {
                    throw error
                }
                sleep(1)
                continue
            }
        }
        
        let gqlPayload = try DataSerializer.decodeJSON(data: httpResp!) as GraphQLRespPayload<RenewAccessTokenResponse>
        
        if let errors = gqlPayload.errors {
            if errors.first?.message == GraphQLErrorMessage.noRefreshTokenOnServer.rawValue {
                throw GraphQLError.noRefreshTokenUnauthUser
            }
            throw GraphQLError.mutation(error: errors)
        }
        
        guard let gqlData = gqlPayload.data else {
            throw GraphQLError.unavailableData(queryName: "renewAcessToken")
        }
        
        KeychainManager.shared.removeTokenByKey(key: KeychainKey.accessToken)
       
        try KeychainManager.shared.saveToKeychain(
            token: gqlData.renewAccessToken!.accessToken.trimmingCharacters(in: .whitespacesAndNewlines),
            key: KeychainKey.accessToken
        )
    }
}
