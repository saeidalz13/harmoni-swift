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
    var partnerID: String?
    var familyID: String?
    var familyTitle: String?
    
    init(
        id: String,
        email: String,
        firstName: String? = nil,
        lastName: String? = nil,
        partnerID: String? = nil,
        familyID: String? = nil,
        familyTitle: String? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.partnerID = partnerID
        self.familyID = familyID
        self.familyTitle = familyTitle
    }
}
