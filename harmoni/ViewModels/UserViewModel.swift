//
//  UserViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-04.
//


import SwiftUI

@Observable @MainActor
final class UserViewModel {
    var user: User?
    var partner: User?
    var bond: Bond?
    
    func fetchUserInfo(email: String) async throws {

        let gqlData = try await GraphQLManager.shared.execOperation(
            GraphQLOperationBuilder.userInfo.build(),
            variables: UserInfoVariables(userInfoInput: email),
            withBearer: true
        ) as UserInfoResponse
        
        guard let userInfo = gqlData.userInfo else {
            throw GraphQLError.unavailableData(queryName: GraphQLOperationBuilder.userInfo.operationName)
        }
        
        user = userInfo.user
        partner = userInfo.partner
        bond = userInfo.bond
    }
    
    func fetchPartner() async throws {
        guard let b = self.bond else {
            throw GeneralError.optionalFieldUnavailable(fieldName: "bond")
        }
        
        var gqlData: PartnerInfoResponse?
        do {
            gqlData = try await GraphQLManager.shared.execOperation(
                GraphQLOperationBuilder.partnerInfo.build(),
                variables: PartnerInfoVariables(partnerInfoInput: b.id),
                withBearer: true
            ) as PartnerInfoResponse
            
        } catch GraphQLError.mutation(let errors) {
            if errors.first?.message == GraphQLErrorMessage.noPartner.rawValue {
                partner = nil
            }
            throw GeneralError.optionalFieldUnavailable(fieldName: "partner")
            
        } catch {
            throw error
        }
        
        guard let partnerInfoPayload = gqlData!.partnerInfo else {
            throw GraphQLError.unavailableData(queryName: GraphQLOperationBuilder.partnerInfo.operationName)
        }
        
        partner = partnerInfoPayload.partner
    }
}
