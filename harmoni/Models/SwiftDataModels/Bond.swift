//
//  Bond.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-28.
//

import Foundation
import SwiftData


@Model
final class BondModel: Identifiable {
    @Attribute(.unique) var id: String
    var title: String
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade)
    var chapters: [ChapterModel] = []
    
    @Relationship(deleteRule: .nullify, inverse: \LocalUser.bond)
    var user: LocalUser?
    
    init(id: String, title: String, createdAt: Date) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
    }
}
