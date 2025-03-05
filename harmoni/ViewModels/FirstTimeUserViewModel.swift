//
//  FirstTimeUserViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-02.
//
import SwiftUI

@Observable @MainActor
final class FirstTimeUserViewModel {
    
    func createBond(firstName: String, lastName: String, birthDate: String, bondTitle: String) async throws {
        let gqlData = try await GraphQLManager.shared.execOperation(
            GraphQLOperationBuilder.createBond.build(),
            variables: CreateBondVariables(
                createBondInput: CreateBondInput(firstName: firstName, lastName: lastName, birthDate: birthDate, bondTitle: bondTitle)
            ),
            withBearer: true
        ) as CreateBondResponse
        
        print(gqlData.createBond)
    }
    
    func joinBond(firstName: String, lastName: String, birthDate: String, bondId: String) async throws {
        let gqlData = try await GraphQLManager.shared.execOperation(
            GraphQLOperationBuilder.joinBond.build(),
            variables: JoinBondVariables(
                joinBondInput: JoinBondInput(firstName: firstName, lastName: lastName, birthDate: birthDate, bondId: bondId)
            ),
            withBearer: true
        ) as JoinBondResponse
        
        print(gqlData.joinBond)
    }
    
}
