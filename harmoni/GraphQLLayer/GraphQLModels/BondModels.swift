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
    let firstName: String
    let lastName: String
    let birthDate: String
    let bondTitle: String
}

struct CreateBondVariables: Codable {
    let createBondInput: CreateBondInput
}

//struct CreateBondPayload: Codable {
//    let bondId: String
//}

struct CreateBondResponse: Codable {
    let createBond: String
}

//
struct UpdateBondInput: Codable {
    let bondId: String
    let bondTitle: String
}

struct UpdateBondResponse: Codable {
    let updateBond: Bond?
}

//
struct JoinBondInput: Codable {
    let firstName: String
    let lastName: String
    let birthDate: String
    let bondId: String
}

struct JoinBondVariables: Codable {
    let joinBondInput: JoinBondInput
}

//struct JoinBondPayload: Codable {
//    let bondId: String
//}

struct JoinBondResponse: Codable {
    let joinBond: String
}
