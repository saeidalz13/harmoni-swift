//
//  ChapterViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-01.
//

import SwiftData

@Observable @MainActor
final class RelationshipViewModel {
    var chapters: [Chapter] = .init()
    
    func createChapter(bondId: String, chapterTitle: String, chapterDays: Int) async throws {        
        let _ = try await GraphQLManager.shared.execOperation(
            GraphQLOperationBuilder.createChapter.build(),
            variables: CreateChapterVariables(
                createChapterInput: CreateChapterInput(
                    bondId: bondId,
                    chapterTitle: chapterTitle,
                    chapterDays: chapterDays
                )
            )
        ) as CreateChapterResponse
    }
    
    
}
