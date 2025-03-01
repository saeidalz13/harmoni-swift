//
//  ChapterViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-01.
//

import SwiftData

@Observable @MainActor
final class ChapterViewModel {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}
