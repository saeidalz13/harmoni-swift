//
//  LocalUser.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-06.
//

import Foundation
import SwiftData

// @Model macro updates the class with conformance to the PersistentModel protocol,
// which SwiftData uses to examine the class and generate an internal schema.
// Also add conformance to Observable
@Model
final class LocalUser: Identifiable {
    @Attribute(.unique) var id: String
    @Attribute(.unique) var email: String
    var firstName: String?
    var lastName: String?
    
    @Relationship(deleteRule: .cascade)
    var bond: BondModel?

    var partnerId: String?
    var partnerEmail: String?
    var partnerFirstName: String?
    var partnerLastName: String?
    
    init(
        id: String,
        email: String,
        firstName: String? = nil,
        lastName: String? = nil,
        bond: BondModel? = nil,
        partnerId: String? = nil,
        partnerEmail: String? = nil,
        partnerFirstName: String? = nil,
        partnerLastName: String? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.bond = bond
        self.partnerId = partnerId
        self.partnerEmail = partnerEmail
        self.partnerFirstName = partnerFirstName
        self.partnerLastName = partnerLastName
    }
    
    static func fetchUser(by email: String, modelContext: ModelContext) throws -> LocalUser {
        let  fd = FetchDescriptor<LocalUser>(
            predicate: #Predicate { $0.email == email }
        )
        
        guard let localUser = try modelContext.fetch(fd).first else {
            throw ModelContextError.notFound(modelName: "LocalUser")
        }
        
        return localUser
    }
    
//    static func updatePersonalInfo(
//        id: String,
//        email: String,
//        firstName: String,
//        lastName: String,
//        modelContext: ModelContext
//    ) throws {
//        let fetchDescriptor = FetchDescriptor<LocalUser>(
//            predicate: #Predicate { $0.id == id }
//        )
//        
//        guard let existingUser = try modelContext.fetch(fetchDescriptor).first else {
//            throw NSError(domain: "UpdateUserError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
//        }
//        
//        existingUser.email = email
//        existingUser.firstName = firstName
//        existingUser.lastName = lastName
//        
//        try modelContext.save()
//    }
    
//    static func updateBond(id: String, bondTitle: String, modelContext: ModelContext) throws {
//        let fetchDescriptor = FetchDescriptor<LocalUser>(
//            predicate: #Predicate { $0.id == id }
//        )
//        
//        guard let existingUser = try modelContext.fetch(fetchDescriptor).first else {
//            throw NSError(domain: "UpdateUserError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
//        }
//        
//        existingUser.bond!.title = bondTitle
//        
//        try modelContext.save()
//    }
    
//    static func updatePartnerBond(id: String, joinBondPayload: JoinBondPayload, modelContext: ModelContext) throws {
//        let fetchDescriptor = FetchDescriptor<LocalUser>(
//            predicate: #Predicate { $0.id == id }
//        )
//        
//        guard let existingUser = try modelContext.fetch(fetchDescriptor).first else {
//            throw NSError(domain: "UpdateUserError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
//        }
//        
//        existingUser.bondId = joinBondPayload.bondId
//        existingUser.bondTitle = joinBondPayload.bondTitle
//        existingUser.partnerId = joinBondPayload.partnerId
//        existingUser.partnerEmail = joinBondPayload.partnerEmail
//        existingUser.partnerFirstName = joinBondPayload.partnerFirstName
//        existingUser.partnerLastName = joinBondPayload.partnerLastName
//        
//        try modelContext.save()
//    }
    
//    static func updatePartnerInfo(id: String, partnerInfoPayload: PartnerInfoPayload, modelContext: ModelContext) throws {
//        let fetchDescriptor = FetchDescriptor<LocalUser>(
//            predicate: #Predicate { $0.id == id }
//        )
//        
//        guard let existingUser = try modelContext.fetch(fetchDescriptor).first else {
//            throw NSError(domain: "UpdateUserError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
//        }
//        
//        existingUser.partnerId = partnerInfoPayload.partnerId
//        existingUser.partnerEmail = partnerInfoPayload.partnerEmail
//        existingUser.partnerFirstName = partnerInfoPayload.partnerFirstName
//        existingUser.partnerLastName = partnerInfoPayload.partnerLastName
//        
//        try modelContext.save()
//    }
    
//    static func deleteUser(id: String, modelContext: ModelContext) throws {
//        let fetchDescriptor = FetchDescriptor<LocalUser>(
//            predicate: #Predicate { $0.id == id }
//        )
//        
//        guard let existingUser = try modelContext.fetch(fetchDescriptor).first else {
//            throw NSError(domain: "UpdateUserError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
//        }
//        
//        modelContext.delete(existingUser)
//        try modelContext.save()
//    }
//    
//    func setPartnerToNil(modelContext: ModelContext) throws {
//        let existingUser = try fetchUserFromDisk(modelContext: modelContext)
//        
//        existingUser.partnerId = nil
//        existingUser.partnerEmail = nil
//        existingUser.partnerFirstName = nil
//        existingUser.partnerLastName = nil
//        
//        try modelContext.save()
//    }
}
