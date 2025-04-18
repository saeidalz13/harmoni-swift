//
//  HomeViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-01.
//
import SwiftUI

@Observable @MainActor
final class HomeViewModel {
    var recentChapter: Chapter? = nil
    var recentMoments: [Moment] = .init()
    
    func resetChapterMoments() {
        self.recentChapter = nil
        self.recentMoments = .init()
    }
    
    func fetchRecentChapterMoments(bondId: String) async throws {
        let gqlData = try await GraphQLManager.shared.execOperation(
            GraphQLOperationBuilder.homeSummary.build(),
            variables: HomeSummaryInput(
                mostRecentChapterMomentsInput: bondId
            )
        ) as HomeSummaryResponse
        
        if let recentChapterData =  gqlData.mostRecentChapterMoments {
            self.recentChapter = recentChapterData.recentChapter
            self.recentMoments = recentChapterData.recentMoments
        } else {
            resetChapterMoments()
        }
    }
    
}
