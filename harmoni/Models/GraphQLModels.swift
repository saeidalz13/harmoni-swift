//
//  GraphQLModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-01.
//

struct GraphQLRespPayload<T: Codable>: Codable {
    let data: T
}

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

struct AuthPayload: Codable {
    let user: User
    let accessToken: String
    let refreshToken: String
}

struct UpdateUserInput: Codable {
    let email: String
    let firstName: String
    let lastName: String
}

struct LogOutInput: Codable {
    let id: String
}

struct AuthenticateIdTokenResponse: Codable {
    let authenticateIdToken: AuthPayload
}

struct AuthenticateIdTokenInput: Codable {
    let idToken: String
}

struct GraphQLSingleMutation: Codable  {
    let query: String
    let variables: String
}
