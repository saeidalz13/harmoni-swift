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
final class LocalUser {
    @Attribute(.unique) var id: String
    @Attribute(.unique) var email: String
    var firstName: String
    var lastName: String
    var partnerID: String?
    var familyName: String?
    var familyCreatedAt: Date?
    
    init(
        id: String,
        firstName: String,
        lastName: String,
        email: String,
        partnerID: String? = nil,
        familyName: String? = nil,
        familyCreatedAt: Date? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.partnerID = partnerID
        self.familyName = familyName
        self.familyCreatedAt = familyCreatedAt
    }
}
