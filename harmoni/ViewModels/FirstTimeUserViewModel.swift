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
        let _ = try await GraphQLManager.shared.execQuery(
            query: GraphQLQuery.createBond,
            input: CreateBondInput(firstName: firstName, lastName: lastName, birthDate: birthDate, bondTitle: bondTitle),
            type: .mutation,
            withBearer: true
        ) as CreateBondResponse
    }
    
}
