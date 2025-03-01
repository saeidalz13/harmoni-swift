//
//  RelationshipSummaryView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-28.
//

import SwiftUI

struct RelationshipSummaryView: View {
    var body: some View {
        RomanticContainer(backgroundColor: Color(red: 1.0, green: 0.98, blue: 0.92).opacity(0.8)) {
            VStack(spacing: 5) {
                Text("Relationship Summary")
                    .font(.headline)
                
                Divider()
                
                HStack {
                    // TODO: Must be the chapter title
                    Text("🍃 Current Chapter")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.7))
                }
                .padding(.top, 5)
                
                HStack(spacing: 30) {
                    // Cookies
                    VStack {
                        Text("🍪")
                            .font(.system(size: 20))
                        
                        Text("\(22)")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    
                    // Oopsies
                    VStack {
                        Text("🫢")
                            .font(.system(size: 20))
                        
                        Text("\(10)")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                .padding(.vertical, 5)
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
            .layoutPriority(1)
        }
    }
}
