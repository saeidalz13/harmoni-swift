//
//  RESTModels.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-08.
//

struct OAuth2RestResponse: Decodable {
    var isAuth: Bool
    var userId: String
}
