//
//  GraphQLManager.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-01.
//
import Foundation

struct GraphQLRequest<T: Codable>: Codable {
    let query: String
    var variables: T?
}

final class GraphQLManager: Sendable {
    static let shared = GraphQLManager()
    private init() {}
    
    
    func execQuery<T: Codable, U: Codable>(query: GraphQLQuery, input: T?, type: GraphQLRequestType = .mutation, withBearer: Bool) async throws -> U {
        var graphQLRequest = GraphQLRequest(
            query: query.generate(type: type, withInput: input != nil),
            variables: ["input": input]
        )
        if input == nil {
            graphQLRequest.variables = nil
        }
      
        let httpReqBody = try DataSerializer.encodeJSON(value: graphQLRequest)
        
        var retry = true
        var attempts = 0
        var httpResp: Data? = nil
        while retry && attempts < 3 {
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
                
            } catch {
                attempts += 1
                
                if attempts >= 3 {
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
            throw GraphQLError.unavailableData(queryName: query.str)
        }
        
        return gqlData
    }
    
    func renewAccessToken() async throws {
        guard let refreshToken = KeychainManager.shared.retrieveFromKeychain(key: KeychainTokenKey.refreshToken.rawValue) else {
            throw SecurityError.unavailableToken
        }
        
        let graphQLRequest = GraphQLRequest(
            query: GraphQLQuery.renewAccessToken.generate(type: .mutation),
            variables: ["input": RenewAccessTokenInput(refreshToken: refreshToken)]
        )
        
        let httpReqBody = try DataSerializer.encodeJSON(value: graphQLRequest)
        
        var httpResp: Data? = nil
        var retry = true
        var attempts = 0
        
        while retry && attempts < 3 {
            do {
                httpResp = try await NetworkManager.shared.makeHTTPPostRequest(httpBody: httpReqBody, withBearer: false)
                retry = false
            } catch {
                attempts += 1
                if attempts >= 3 {
                    throw error
                }
                sleep(1)
                continue
            }
        }
        
        let gqlPayload = try DataSerializer.decodeJSON(data: httpResp!) as GraphQLRespPayload<RenewAccessTokenResponse>
        
        if let errors = gqlPayload.errors {
            print(errors)
            throw GraphQLError.mutation(error: errors)
        }
        
        guard let gqlData = gqlPayload.data else {
            throw GraphQLError.unavailableData(queryName: "renewAcessToken")
        }
        
        KeychainManager.shared.removeTokenByKey(key: KeychainTokenKey.accessToken.rawValue)
       
        try KeychainManager.shared.saveToKeychain(
            token: gqlData.renewAccessToken!.accessToken.trimmingCharacters(in: .whitespacesAndNewlines),
            key: KeychainTokenKey.accessToken.rawValue
        )
    }
}
