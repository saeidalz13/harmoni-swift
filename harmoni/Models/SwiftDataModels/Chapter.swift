//
//  Chapter.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-28.
//

import Foundation
import SwiftData

@Model
final class ChapterModel: Identifiable {
    @Attribute(.unique) var id: String
    
    @Relationship(deleteRule: .cascade, inverse: \BondModel.chapters)
    var bond: Bond?

    var title: String
    var startedAt: Date
    var endsAt: Date
    var endedAt: Date?
    var createdAt: Date
    var updatedAt: Date
    
    init(id: String, bond: Bond?, title: String, startedAt: Date, endsAt: Date, endedAt: Date? = nil, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.bond = bond
        self.title = title
        self.startedAt = startedAt
        self.endsAt = endsAt
        self.endedAt = endedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
