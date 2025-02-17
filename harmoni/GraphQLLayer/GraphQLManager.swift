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
    func generateHTTPBody<T: Codable>(query: String, variables: T?) throws -> Data {
        var graphQLRequest = GraphQLRequest(query: query, variables: ["input": variables])
        if variables == nil {
            graphQLRequest.variables = nil
        }
      
        return try DataSerializer.encodeJSON(value: graphQLRequest)
    }
}
