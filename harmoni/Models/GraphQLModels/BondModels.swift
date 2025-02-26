//
//  BondModels.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-23.
//
import Foundation

struct Bond: Codable {
    let id: String
    let bondTitle: String
    let createdAt: String
}

//
struct CreateBondInput: Codable {
    let bondTitle: String!
}


struct CreateBondResponse: Codable {
    let createBond: Bond?
}

//
struct UpdateBondInput: Codable {
    let bondId: String
    let bondTitle: String
}

struct UpdateBondResponse: Codable {
    let updateBond: Bond?
}
