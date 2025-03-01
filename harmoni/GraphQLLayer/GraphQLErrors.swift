//
//  GraphQLErrors.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-21.
//

enum GraphQLError: Error {
    case unavailableData(queryName: String)
    case mutation(error: [RespPayloadError])
    
    var localizedDescription: String {
        switch self {
        case .unavailableData(let queryName):
            return "no data available in payload \(queryName)"
        case .mutation(let errors):
            return "error in gql payload: \(errors)"
        }
 
    }
}

enum GraphQLErrorMessage: String {
    case noPartner = "no partner has joined the bond yet"
}
