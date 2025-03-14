//
//  RelationshipSummaryView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-28.
//

import SwiftUI

struct RelationshipSummaryView: View {
    @Environment(UserViewModel.self) private var userVM
    @Environment(HomeViewModel.self) private var homeVM
    @State var shouldRefresh = false
    
    var body: some View {
        RomanticContainer(backgroundColor: Color(red: 1.0, green: 0.98, blue: 0.92).opacity(0.8)) {
            if let chapter = homeVM.recentChapter {
                RelationshipSummaryWithDataView(chapter: chapter, moments: homeVM.recentMoments)
            } else {
                RelationshipSummaryNoDataView(shouldRefresh: $shouldRefresh)
            }
            
        }
        .padding(.horizontal)
        .task {
            fetchRecentChapterMoments()
        }
        .onChange(of: shouldRefresh) {
            fetchRecentChapterMoments()
        }
        
    }
    
    private func fetchRecentChapterMoments() {
        Task {
            do {
                try await homeVM.fetchRecentChapterMoments(bondId: userVM.bond!.id)
            } catch {
                print(error)
            }
        }
    }
}
