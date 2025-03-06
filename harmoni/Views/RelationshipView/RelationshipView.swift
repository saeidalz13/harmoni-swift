//
//  RelationshipView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-27.
//
import SwiftData
import SwiftUI

struct RelationshipView: View {
    @State var isLoadingCreateChapter: Bool = false
    
    var body: some View {
        ScrollView {
            
            // ** start 1
            RomanticContainer {
                VStack {
                    Button {
                        
                    } label: {
                        RomanticLabelView(isLoading: $isLoadingCreateChapter, text: "New Chapter 🍃")
                    }
                }
            }
            // -- end 1
            
            // ** start 2
            RomanticContainer {
                VStack {
                }
            }
            // -- end 2
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
    }
    
}
