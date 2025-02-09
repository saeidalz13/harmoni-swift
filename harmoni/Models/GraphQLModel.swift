//
//  GraphQLModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-01.
//

struct GraphQLData<T: Decodable>: Decodable {
    let data: T
}

struct OAuth2RedirectLinkResponse: Decodable {
    let oauth2RedirectLink: String
}

struct UserInfo: Decodable {
    let id: String
    let email: String
    let firstName: String?
    let lastName: String?
    let familyName: String?
    // other stuff for home (any crucial/recent/summary info)
}
