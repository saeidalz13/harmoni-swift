//
//  RelationshipView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-27.
//
import SwiftData
import SwiftUI

struct RelationshipView: View {
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    
    var sortedChapters: [ChapterModel] {
        guard let user = localUserViewModel.localUser, let bond = user.bond else {
            return []
        }
        
       return bond.chapters.sorted(by: { $0.createdAt > $1.createdAt })
    }

    @State var isLoadingCreateChapter: Bool = false
    
    var body: some View {
        ScrollView {
            
            // ** start 1
            RomanticContainer {
                VStack {
                    Button {
                        Task {
                            do {
                                
                            } catch {
                               print(error)
                            }
                        }
                        
                    } label: {
                        RomanticLabelView(isLoading: $isLoadingCreateChapter, text: "New Chapter 🍃")
                    }
                }
            }
            // -- end 1
            
            // ** start 2
            RomanticContainer {
                VStack {
                    if sortedChapters.isEmpty {
                        Text("No chapters yet.")
                    } else {
                        List(sortedChapters) { chapter in
                            Text(chapter.title)
                        }
                    }
                }
            }
            // -- end 2
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
    }
    
}
