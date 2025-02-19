//
//  ProgressView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-17.
//
import SwiftUI

struct AppProgressView: View {
    private var text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
                .padding()
            Text(text)
                .foregroundColor(.gray)
                .font(.headline)
        }
        .frame(width: 150, height: 150)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

