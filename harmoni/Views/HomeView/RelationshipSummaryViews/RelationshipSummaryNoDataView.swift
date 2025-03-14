//
//  RelationshipSummaryNoDataView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-07.
//

import SwiftUI

struct RelationshipSummaryNoDataView: View {
    @State private var isLoading = false
    @State private var chapterTitle = ""
    @State private var chapterDays: Int? = nil
    @Binding var shouldRefresh: Bool
    
    @Environment(RelationshipViewModel.self) private var relationshipVM
    @Environment(UserViewModel.self) private var userVM
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Image(systemName: "book.fill")
                        .foregroundColor(.softPink)
                    Text("Let's create a chapter! 🍃")
                        .font(.avenirBold)
                    Spacer()
                }
                
                Text("Chapters help you organize your journey together. Each chapter represents a meaningful period in your relationship that you can look back on.")
                    .font(.avenirBody)
                
                
                HStack {
                    Spacer()
                    Text("Begin below ↓")
                        .font(.avenirCaption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.vertical, 10)

            }
            
            Divider()
                .padding(.bottom, 10)
            
            
            RomanticTextField(fieldText: "Name this chapter", varToEdit: $chapterTitle)
                .padding(.bottom, 5)
            RomanticDropdownView(
                fieldText: "How many days should it last?",
                varToEdit: $chapterDays,
                values: [7, 15, 30, 60, 90, 120, 180]
            )
            .padding(.bottom, 10)
            
            RomanticButton(isLoading: $isLoading, text: "Begin Chapter...", action: createChapter)
        }
        
    }
    
    private func createChapter() async -> ButtonActionResult {
        do {
            // Should crash. this should never happen
//            guard let bond = userVM.bond else {
//                return .notFulfilled("bond ID not available. Something's fishy...")
//            }
            
            let ct = chapterTitle.trimmingCharacters(in: .whitespacesAndNewlines)
            if ct  == "" {
                return .notFulfilled("you need to pick a title!")
            }
            
            guard let days = chapterDays else {
                return .notFulfilled("you need to pick days!")
            }
            
            try await relationshipVM.createChapter(bondId: userVM.bond!.id, chapterTitle: ct, chapterDays: days)
            
            shouldRefresh = !shouldRefresh
            return .fulfilled("Success")

        } catch {
            print(error)
            return .serverError
        }
    }
}
