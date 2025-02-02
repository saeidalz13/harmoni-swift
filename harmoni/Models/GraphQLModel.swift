//
//  GraphQLModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-01.
//

struct GraphQLData<T: Decodable>: Decodable {
    let data: T
}

struct RedirectURLResponse: Decodable {
    let oauth2RedirectLink: String
}