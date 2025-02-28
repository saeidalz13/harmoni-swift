//
//  AuthViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-30.
//
import SwiftUI
import SwiftData
import GoogleSignIn

@Observable @MainActor
final class LocalUserViewModel {
    private var modelContext: ModelContext
    private var _localUser: LocalUser?
    
    var localUser: LocalUser? {
        get { return _localUser }
        set { _localUser = newValue }
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func authenticateBackend(idToken: String) async {
        do {
            let gqlData = try await GraphQLManager.shared.execQuery(
                query: GraphQLQuery.authenticateIdToken,
                input: AuthenticateIdTokenInput.init(
                    idToken: idToken
                ),
                withBearer: false
            ) as AuthenticateIdTokenResponse
            
            let authPayload = gqlData.authenticateIdToken
            
            try KeychainManager.shared.saveTokensToKeychain(
                accessToken: authPayload!.accessToken,
                refreshToken: authPayload!.refreshToken
            )
            
            self.localUser = try LocalUser.saveNew(user: authPayload!.user, modelContext: modelContext)
            
        } catch {
            print("Authorization failed: \(error.localizedDescription)")
            KeychainManager.shared.removeTokensFromKeychain()
            GIDSignIn.sharedInstance.signOut()
            self.localUser = nil
        }
    }
    
    func updateUser(email: String, firstName: String, lastName: String) async throws {
        let gqlData = try await GraphQLManager.shared.execQuery(
            query: GraphQLQuery.updateUser,
            input: UpdateUserInput.init(
                email: email,
                firstName: firstName,
                lastName: lastName
            ),
            withBearer: true
        ) as UpdateUserResponse
        
        self.localUser!.email = email
        self.localUser!.firstName = firstName
        self.localUser!.lastName = lastName
        
        try LocalUser.updatePersonalInfo(
            id: gqlData.updateUser!.id,
            email: email,
            firstName: firstName,
            lastName: lastName,
            modelContext: modelContext
        )
    }
    
    func updateBond(bondTitle: String) async throws {
        guard let bondId = localUser!.bondId else {
            throw GeneralError.optionalFieldUnavailable(fieldName: "bondId")
        }
        
        let gqlData = try await GraphQLManager.shared.execQuery(
            query: GraphQLQuery.updateBond,
            input: UpdateBondInput(bondId: bondId, bondTitle: bondTitle),
            withBearer: true
        ) as UpdateBondResponse
        
        try LocalUser.updateBond(
            id: localUser!.id,
            bondId: gqlData.updateBond!.id,
            bondTitle: bondTitle,
            modelContext: modelContext
        )
        print(gqlData.updateBond!.createdAt)
        
        localUser!.bondTitle = bondTitle
        localUser!.bondId = gqlData.updateBond!.id
    }
    
    func createBond(bondTitle: String) async throws {
        let gqlData = try await GraphQLManager.shared.execQuery(
            query: GraphQLQuery.createBond,
            input: CreateBondInput(bondTitle: bondTitle),
            withBearer: true
        ) as CreateBondResponse
        
        try LocalUser.updateBond(
            id: localUser!.id,
            bondId: gqlData.createBond!.id,
            bondTitle: bondTitle,
            modelContext: modelContext
        )
        
        localUser!.bondTitle = bondTitle
        localUser!.bondId = gqlData.createBond!.id
    }
    
    func joinBond(bondId: String) async throws {
        let gqlData = try await GraphQLManager.shared.execQuery(
            query: GraphQLQuery.joinBond,
            input: JoinBondInput(bondId: bondId),
            withBearer: true
        ) as JoinBondResponse
        
        let joinBondPayload = gqlData.joinBond!
        
        try LocalUser.updatePartnerBond(
            id: localUser!.id,
            joinBondPayload: joinBondPayload,
            modelContext: modelContext
        )
        
        localUser!.bondId = joinBondPayload.bondId
        localUser!.bondTitle = joinBondPayload.bondTitle
        localUser!.partnerId = joinBondPayload.partnerId
        localUser!.partnerEmail = joinBondPayload.partnerEmail
        localUser!.partnerFirstName = joinBondPayload.partnerFirstName
        localUser!.partnerLastName = joinBondPayload.partnerLastName
    }
    
    func getPartner() async throws {
        guard let bondId = localUser!.bondId else {
            throw GeneralError.optionalFieldUnavailable(fieldName: "bondId")
        }
        
        let gqlData = try await GraphQLManager.shared.execQuery(
            query: GraphQLQuery.partnerInfo,
            input: PartnerInfoInput(bondId: bondId),
            type: .query,
            withBearer: true
        ) as PartnerInfoResponse
        
        
        let partnerInfoPayload = gqlData.partnerInfo!
        
        try LocalUser.updatePartnerInfo(
            id: localUser!.id,
            partnerInfoPayload: partnerInfoPayload,
            modelContext: modelContext
        )
        
        localUser!.partnerId = partnerInfoPayload.partnerId
        localUser!.partnerEmail = partnerInfoPayload.partnerEmail
        localUser!.partnerFirstName = partnerInfoPayload.partnerFirstName
        localUser!.partnerLastName = partnerInfoPayload.partnerLastName
    }
    
    func logOutBackend() async throws {
        do {
            let _ = try await GraphQLManager.shared.execQuery(
                query: GraphQLQuery.logOut,
                input: UserIdResponse.init(id: localUser!.id),
                withBearer: true
            ) as LogOutInput
            
            // TODO: remove this
//            try LocalUser.deleteUser(id: localUser!.id, modelContext: modelContext)
//            print("deleted user")

        } catch {
            print("Failed to delete refresh token from backend: \(error)")
        }
        
        KeychainManager.shared.removeTokensFromKeychain()
        GIDSignIn.sharedInstance.signOut()
        localUser = nil
    }
    
}

