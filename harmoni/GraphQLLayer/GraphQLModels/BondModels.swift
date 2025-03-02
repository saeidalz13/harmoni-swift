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

struct CreateBondPayload: Codable {
    let bondId: String
}

struct CreateBondResponse: Codable {
    let createBond: CreateBondPayload?
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

struct JoinBondPayload: Codable {
    let bondId: String
    let bondTitle: String
    let bondCreatedAt: String
    let partnerId: String
    let partnerEmail: String
    let partnerFirstName: String?
    let partnerLastName: String?
}

struct JoinBondResponse: Codable {
    let joinBond: JoinBondPayload?
}
