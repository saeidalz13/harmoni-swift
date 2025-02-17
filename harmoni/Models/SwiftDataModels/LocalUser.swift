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
    var familyId: String?
    var familyTitle: String?
    var partnerId: String?
    var partnerEmail: String?
    var partnerFirstName: String?
    var partnerLastName: String?
    
    init(
        id: String,
        email: String,
        firstName: String? = nil,
        lastName: String? = nil,
        familyId: String? = nil,
        familyTitle: String? = nil,
        partnerId: String? = nil,
        partnerEmail: String? = nil,
        partnerFirstName: String? = nil,
        partnerLastName: String? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.familyId = familyId
        self.familyTitle = familyTitle
        self.partnerId = partnerId
        self.partnerEmail = partnerEmail
        self.partnerFirstName = partnerFirstName
        self.partnerLastName = partnerLastName
    }
}
