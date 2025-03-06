//
//  BondPopoverView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-05.
//

import SwiftUI

struct BondPopoverView: View {
    var bondTitle: String
    
    @State var newBondTitle = ""
    @State private var isLoading: Bool = false

    var body: some View {
        VStack(alignment: .center) {
            Text("Title: \(bondTitle)")
                .font(.headline)
            
            Divider()
            
            TextField("New Title", text: $newBondTitle)
                .padding(5)
                .background(Color(.systemGray.withAlphaComponent(0.1)))
                .cornerRadius(10)
            
            Button {
                Task {
                    // TODO: Put update bond functionality here
                }
            } label: {
                RomanticLabelView(
                    isLoading: $isLoading,
                    text: "Update",
                    systemImage: "list.bullet.clipboard.fill"
                )
            }
            
        }
        
    }
}
