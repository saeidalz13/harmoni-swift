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
    
//    func updateUser(email: String, firstName: String, lastName: String) async throws {
//        let _ = try await GraphQLManager.shared.execOperation(
//            query: GraphQLOperation.updateUser,
//            variables: UpdateUserInput.init(
//                email: email,
//                firstName: firstName,
//                lastName: lastName
//            ),
//            withBearer: true
//        ) as UpdateUserResponse
//        
//        localUser!.email = email
//        localUser!.firstName = firstName
//        localUser!.lastName = lastName
//        
//        try modelContext.save()
//    }
//    
//    func updateBond(bondTitle: String) async throws {
//        guard let bond = localUser!.bond else {
//            throw GeneralError.optionalFieldUnavailable(fieldName: "bondId")
//        }
//        
//        let gqlData = try await GraphQLManager.shared.execOperation(
//            query: GraphQLOperation.updateBond,
//            variables: UpdateBondInput(bondId: bond.id, bondTitle: bondTitle),
//            withBearer: true
//        ) as UpdateBondResponse
//        
//        guard let respBondTitle = gqlData.updateBond?.bondTitle else {
//            throw GraphQLError.unavailableData(queryName: "updateBond")
//        }
        
        //        try LocalUser.updateBond(
        //            id: localUser!.id,
        //            bondTitle: respBondTitle,
        //            modelContext: modelContext
        //        )
//        
//        localUser!.bond!.title = respBondTitle
//        try modelContext.save()
//    }
    
//    func joinBond(bondId: String) async throws {
//        let gqlData = try await GraphQLManager.shared.execQuery(
//            query: GraphQLQuery.joinBond,
//            input: JoinBondInput(bondId: bondId),
//            withBearer: true
//        ) as JoinBondResponse
//        
//        guard let joinBondPayload = gqlData.joinBond else {
//            throw GraphQLError.unavailableData(queryName: "joinBond")
//        }
//        
//        let bond = BondModel(
//            id: joinBondPayload.bondId,
//            title: joinBondPayload.bondTitle,
//            createdAt: DateFormatter.HarmoniFormatter.date(from: joinBondPayload.bondCreatedAt) ?? Date()
//        )
//        
//        localUser!.bond = bond
//        localUser!.partnerId = joinBondPayload.partnerId
//        localUser!.partnerEmail = joinBondPayload.partnerEmail
//        localUser!.partnerFirstName = joinBondPayload.partnerFirstName
//        localUser!.partnerLastName = joinBondPayload.partnerLastName
//        
//        try modelContext.save()
//    }
    
}

