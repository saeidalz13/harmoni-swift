//
//  AuthViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-30.
//
import SwiftUI
import SwiftData


@Observable @MainActor
final class AuthViewModel {
    private var networkManager: NetworkManager
    private var graphQLManager: GraphQLManager
    private var modelContext: ModelContext
    private var _localUser: LocalUser?

    var localUser: LocalUser? {
        get { return _localUser }
        set { _localUser = newValue }
    }


    init(networkManager: NetworkManager, graphQLManager: GraphQLManager, modelContext: ModelContext) {
        self.networkManager = networkManager
        self.graphQLManager = graphQLManager
        self.modelContext = modelContext
    }
    
    func authenticateBackend(idToken: String) async throws -> LocalUser {
        do {            
            let httpBody = try graphQLManager.generateHTTPBody(
                query: GraphQLQuery.authenticateIdToken.generate(type: .mutation),
                variables: AuthenticateIdTokenInput.init(idToken: idToken)
            )

            let respData = try await networkManager.makeHTTPPostRequest(httpBody: httpBody)
            let userResp = try DataSerializer.decodeJSON(data: respData) as GraphQLRespPayload<AuthenticateIdTokenResponse>

            let authPayload = userResp.data.authenticateIdToken            
            let localUser = LocalUser.init(
                id: authPayload.user.id,
                email: authPayload.user.email,
                firstName: authPayload.user.firstName,
                lastName: authPayload.user.lastName,
                familyId: authPayload.user.familyId,
                familyTitle: authPayload.user.familyTitle,
                partnerId: authPayload.user.partnerId,
                partnerEmail: authPayload.user.partnerEmail,
                partnerFirstName: authPayload.user.partnerFirstName,
                partnerLastName: authPayload.user.partnerLastName
            )
        
            try SecurityManager.saveToKeychain(token: authPayload.accessToken, key: KeychainTokenKey.accessToken.rawValue)
            try SecurityManager.saveToKeychain(token: authPayload.refreshToken, key: KeychainTokenKey.refreshToken.rawValue)
            
            modelContext.insert(localUser)
            try modelContext.save()
 
            return localUser

        } catch {
            print("Failed to setAuthorize")
            throw error
        }
    }
    
    func updateUser(email: String, firstName: String, lastName: String) async throws {
        let accessToken = SecurityManager.retrieveFromKeychain(key: KeychainTokenKey.accessToken.rawValue)
        guard let accessToken = accessToken else { throw SecurityError.unavailableToken }
        
        let httpBody = try graphQLManager.generateHTTPBody(
            query: GraphQLQuery.updateUser.generate(type: .mutation),
            variables: UpdateUserInput.init(
                email: email,
                firstName: firstName,
                lastName: lastName
            )
        )
        
        _ = try await networkManager.makeHTTPPostRequest(httpBody: httpBody, bearerToken: accessToken)
        
        self.localUser!.email = email
        self.localUser!.firstName = firstName
        self.localUser!.lastName = lastName
        
        try modelContext.save()
    }

}

