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
    let birthDate: String?
}

struct UserInfo: Codable {
    let user: User
    let partner: User?
    let bond: Bond?
}

// User Info Query
struct UserInfoResponse: Codable {
    let userInfo: UserInfo?
}

//struct UserInfoInput: Codable {
//    let email: String
//}

struct UserInfoVariables: Codable {
    let userInfoInput: String
}


// Update User
struct UpdateUserInput: Codable {
    let email: String
    let firstName: String
    let lastName: String
}

struct UpdateUserVariables: Codable {
    let updateUserInput: UpdateUserInput
}

//struct UserIdResponse: Codable {
//    let id: String
//}

struct UpdateUserResponse: Codable {
    let updateUser: String
}

// Authentication
struct AuthenticateIdTokenPayload: Codable {
    let accessToken: String
    let refreshToken: String
}

struct AuthenticateIdTokenResponse: Codable {
    let authenticateIdToken: AuthenticateIdTokenPayload?
}

struct AuthenticateIdTokenInput: Codable {
    let idToken: String
}

struct AuthenticateIdTokenVariables: Codable {
    let authenticateIdTokenInput: AuthenticateIdTokenInput
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
struct LogOutResponse: Codable  {
    let logOut: String
}

// partner
//struct PartnerInfoInput: Codable {
//    let bondId: String
//}

struct PartnerInfoVariables: Codable {
    let partnerInfoInput: String
}

struct PartnerInfoPayload: Codable {
    let partner: User
}

struct PartnerInfoResponse: Codable {
    let partnerInfo: PartnerInfoPayload?
}
