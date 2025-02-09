//
//  RESTModels.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-08.
//

struct OAuth2RestResponse: Decodable {
    var isAuth: Bool
    var userId: String
    var email: String
    var familyId: String?
    var familyTitle: String?
    var firstName: String?
    var lastName: String?
    var partnerId: String?
}
