//
//  AuthViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-30.
//
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
            
            // Check if bond exists
            var bond: BondModel?
            let bondId = authPayload!.user.bondId
            if let bi = bondId {
                let fd = FetchDescriptor<BondModel>(
                    predicate: #Predicate { $0.id == bi }
                )
                if let b = try modelContext.fetch(fd).first {
                    bond = b
                } else {
                    if let bondId = authPayload?.user.bondId,
                       let bondTitle = authPayload?.user.bondTitle,
                       let bondCreatedAt = authPayload?.user.bondCreatedAt,
                       !bondId.isEmpty, !bondTitle.isEmpty, !bondCreatedAt.isEmpty {
                        
                        bond = BondModel(
                            id: bondId,
                            title: bondTitle,
                            createdAt: DateFormatter.HarmoniFormatter.date(from: bondCreatedAt) ?? Date()
                        )
                    }
                }
            }
            
            let lu = LocalUser.init(
                id: authPayload!.user.id,
                email: authPayload!.user.email,
                firstName: authPayload!.user.firstName,
                lastName: authPayload!.user.lastName,
                bond: bond,
                partnerId: authPayload!.user.partnerId,
                partnerEmail: authPayload!.user.partnerEmail,
                partnerFirstName: authPayload!.user.partnerFirstName,
                partnerLastName: authPayload!.user.partnerLastName
            )
            
            modelContext.insert(lu)
            try modelContext.save()
            
            localUser = lu
            
        } catch {
            print("Authorization failed: \(error.localizedDescription)")
            KeychainManager.shared.removeTokensFromKeychain()
            GIDSignIn.sharedInstance.signOut()
            self.localUser = nil
        }
    }
    
    func updateUser(email: String, firstName: String, lastName: String) async throws {
        let _ = try await GraphQLManager.shared.execQuery(
            query: GraphQLQuery.updateUser,
            input: UpdateUserInput.init(
                email: email,
                firstName: firstName,
                lastName: lastName
            ),
            withBearer: true
        ) as UpdateUserResponse
        
        localUser!.email = email
        localUser!.firstName = firstName
        localUser!.lastName = lastName
        
        try modelContext.save()
    }
    
    func updateBond(bondTitle: String) async throws {
        guard let bond = localUser!.bond else {
            throw GeneralError.optionalFieldUnavailable(fieldName: "bondId")
        }
        
        let gqlData = try await GraphQLManager.shared.execQuery(
            query: GraphQLQuery.updateBond,
            input: UpdateBondInput(bondId: bond.id, bondTitle: bondTitle),
            withBearer: true
        ) as UpdateBondResponse
        
        guard let respBondTitle = gqlData.updateBond?.bondTitle else {
            throw GraphQLError.unavailableData(queryName: "updateBond")
        }
        
        //        try LocalUser.updateBond(
        //            id: localUser!.id,
        //            bondTitle: respBondTitle,
        //            modelContext: modelContext
        //        )
        
        localUser!.bond!.title = respBondTitle
        try modelContext.save()
    }
    
    func createBond(bondTitle: String) async throws {
        let gqlData = try await GraphQLManager.shared.execQuery(
            query: GraphQLQuery.createBond,
            input: CreateBondInput(bondTitle: bondTitle),
            withBearer: true
        ) as CreateBondResponse
        
        guard let newBond = gqlData.createBond else {
            throw GraphQLError.unavailableData(queryName: "createBond")
        }
        
        let bond = BondModel(
            id: newBond.id,
            title: newBond.bondTitle,
            createdAt: DateFormatter.HarmoniFormatter.date(from: newBond.createdAt) ?? Date()
        )
        
        modelContext.insert(bond)
        localUser!.bond = bond
        
        try modelContext.save()
    }
    
    func joinBond(bondId: String) async throws {
        let gqlData = try await GraphQLManager.shared.execQuery(
            query: GraphQLQuery.joinBond,
            input: JoinBondInput(bondId: bondId),
            withBearer: true
        ) as JoinBondResponse
        
        guard let joinBondPayload = gqlData.joinBond else {
            throw GraphQLError.unavailableData(queryName: "joinBond")
        }
        
        let bond = BondModel(
            id: joinBondPayload.bondId,
            title: joinBondPayload.bondTitle,
            createdAt: DateFormatter.HarmoniFormatter.date(from: joinBondPayload.bondCreatedAt) ?? Date()
        )
        
        localUser!.bond = bond
        localUser!.partnerId = joinBondPayload.partnerId
        localUser!.partnerEmail = joinBondPayload.partnerEmail
        localUser!.partnerFirstName = joinBondPayload.partnerFirstName
        localUser!.partnerLastName = joinBondPayload.partnerLastName
        
        try modelContext.save()
    }
    
    func getPartner() async throws {
        guard let bond = localUser!.bond else {
            throw GeneralError.optionalFieldUnavailable(fieldName: "bondId")
        }
        
        var gqlData: PartnerInfoResponse?
        do {
            gqlData = try await GraphQLManager.shared.execQuery(
                query: GraphQLQuery.partnerInfo,
                input: PartnerInfoInput(bondId: bond.id),
                type: .query,
                withBearer: true
            ) as PartnerInfoResponse
            
        } catch GraphQLError.mutation(let errors) {
            if errors.first?.message == GraphQLErrorMessage.noPartner.rawValue {
                localUser!.partnerId = nil
                localUser!.partnerEmail = nil
                localUser!.partnerFirstName = nil
                localUser!.partnerLastName = nil
                try modelContext.save()
            }
            throw GraphQLError.mutation(error: errors)
            
        } catch {
            throw error
        }
        
        let partnerInfoPayload = gqlData!.partnerInfo!
        
        localUser!.partnerId = partnerInfoPayload.partnerId
        localUser!.partnerEmail = partnerInfoPayload.partnerEmail
        localUser!.partnerFirstName = partnerInfoPayload.partnerFirstName
        localUser!.partnerLastName = partnerInfoPayload.partnerLastName
        
        try modelContext.save()
    }
    
//    func logOutBackend() async throws {
//        KeychainManager.shared.removeTokensFromKeychain()
//        GIDSignIn.sharedInstance.signOut()
//        
        //        do {
        //            let _ = try await GraphQLManager.shared.execQuery(
        //                query: GraphQLQuery.logOut,
        //                input: UserIdResponse.init(id: localUser!.id),
        //                withBearer: true
        //            ) as LogOutInput
        //
        //            // TODO: remove this
        //            if let lu = localUser {
        //                modelContext.delete(lu)
        //                try modelContext.save()
        //            }
        
        //        } catch {
        //            print("Failed to delete refresh token from backend: \(error)")
        //        }
        //
        //        KeychainManager.shared.removeTokensFromKeychain()
        //        GIDSignIn.sharedInstance.signOut()
        //        localUser = nil
        //    }
//    }
}

