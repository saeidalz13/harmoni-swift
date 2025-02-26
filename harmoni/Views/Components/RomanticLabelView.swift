//
//  RomanticLabelView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-25.
//
import SwiftUI

struct RomanticLabelView: View {
    @Binding var isLoading: Bool
    var systemImage: String
    var text: String
    
    var body: some View {
        LabelContent(isLoading: isLoading, text: text, systemImage: systemImage)
            .padding(8)
            .background(isLoading ? LinearGradient(
                colors: [.black, .black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing) : LinearGradient(
                    colors: [Color.pink, Color.red],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 3)
            .opacity(isLoading ? 0.8 : 1.0)
            .animation(.easeInOut, value: isLoading)
    }
}

struct LabelContent: View {
    var isLoading: Bool
    var text: String
    var systemImage: String
    
    var body: some View {
        if isLoading {
            HStack(spacing: 0.1) {
                HeartView(delay: 0.0)
                HeartView(delay: 0.2)
                HeartView(delay: 0.4)
            }
        } else {
            Label(text, systemImage: systemImage)
        }
    }
}

struct HeartView: View {
    var delay: Double
    @State private var scale: CGFloat = 0.7
    
    var body: some View {
        Image(systemName: "heart.fill")
            .foregroundColor(.red)
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
