//
//  AuthModels.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-23.
//

// General User
struct User: Codable {
    let id: String
    let email: String
    let firstName: String?
    let lastName: String?
    let bondTitle: String?
    let bondId: String?
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
