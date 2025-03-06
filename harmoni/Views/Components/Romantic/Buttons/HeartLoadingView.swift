//
//  HeartLoadingView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-04.
//
import SwiftUI

struct HeartLoadingView: View {
    var delay: Double
    @State private var scale: CGFloat = 0.7
    
    var body: some View {
        Image(systemName: "heart.fill")
            .foregroundColor(.pink)
            .scaleEffect(scale)
            .animation(
                Animation.easeInOut(duration: 0.6)
                    .repeatForever(autoreverses: true)
                    .delay(delay),
                value: scale
            )
            .onAppear {
                scale = 1.1
            }
    }
}
