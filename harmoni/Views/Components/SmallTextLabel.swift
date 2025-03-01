//
//  SmallTextLabel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-28.
//
import SwiftUI

struct SmallTextLabel: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .background(.gray.opacity(0.1))
            .cornerRadius(20)
    }
}
