//
//  AuthViewSlideLast.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-01.
//

import SwiftUI

struct AuthViewSlideLast: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.circle.fill")
                .font(.system(size: 60, design: .serif))
                .foregroundStyle(
                    LinearGradient(colors: [.pink, .purple],
                                  startPoint: .topLeading,
                                  endPoint: .bottomTrailing)
                )
                .shadow(radius: 5)
                .padding(.bottom, 10)
            
            Text("Begin Your Journey")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Text("Where moments become memories\nand love finds its digital home")
                .font(.callout)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Text("Sign In Today!")
                .font(.headline)
                .padding(.top, 10)
                .foregroundColor(.primary)
        }
    }
}
