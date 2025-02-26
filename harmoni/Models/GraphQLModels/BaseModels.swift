//
//  GraphQLModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-01.
//

// General GraphQL Schemas
struct RespPayloadErrorLocation: Codable {
    let line: Int
    let column: Int
}

struct RespPayloadError: Codable {
    let message: String
    let locations: [RespPayloadErrorLocation]?
    let path: [String]?
}

struct GraphQLRespPayload<T: Codable>: Codable {
    let data: T?
    let errors: [RespPayloadError]?
}
