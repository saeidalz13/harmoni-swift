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

// General User
struct User: Codable {
    let id: String
    let email: String
    let firstName: String?
    let lastName: String?
    let familyTitle: String?
    let familyId: String?
    let partnerId: String?
    let partnerEmail: String?
    let partnerFirstName: String?
    let partnerLastName: String?
}


// Update User
struct UpdateUserInput: Codable {
    let email: String
    let firstName: String
    let lastName: String
}

struct UserIdResponse: Codable {
    let id: String
}

struct UpdateUserResponse: Codable {
    let updateUser: UserIdResponse?
}

// Authentication
struct AuthPayload: Codable {
    let user: User
    let accessToken: String
    let refreshToken: String
}

struct AuthenticateIdTokenResponse: Codable {
    let authenticateIdToken: AuthPayload?
}

struct AuthenticateIdTokenInput: Codable {
    let idToken: String
}

// Renewal access Token
struct RenewAccessTokenInput: Codable {
    let refreshToken: String
}

struct RenewAccessTokenOutput: Codable {
    let id: String
    let accessToken: String
}

struct RenewAccessTokenResponse: Codable {
    let renewAccessToken: RenewAccessTokenOutput?
}

// logout
struct LogOutInput: Codable  {
    let logOut: UserIdResponse?
}
