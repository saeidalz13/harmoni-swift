//
//  RomanticLabelView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-25.
//
import SwiftUI

struct RomanticLabelView: View {
    // TODO: Add a success binding variable to this
    @Binding var isLoading: Bool
    var text: String
    
    var systemImage: String?
    var linearGradient: LinearGradient = LinearGradient(
        colors: [.pink],
        startPoint: .leading,
        endPoint: .trailing
    )
    var verticalPadding: CGFloat = 10
    var horizontalPadding: CGFloat = 20
    var cornerRadius: CGFloat = 20
    var shadowColor: Color = .pink.opacity(0.15)
    
    let loadingLG = LinearGradient(colors: [.black], startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        LabelContent(isLoading: isLoading, text: text, systemImage: systemImage ?? "")
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .background(isLoading ? loadingLG : linearGradient)
            .foregroundColor(.white)
            .cornerRadius(cornerRadius)
            .shadow(color: shadowColor, radius: 8, x: 0, y: 6)
            .opacity(isLoading ? 0.7 : 1.0)
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
            // TODO: based on isSuccess binding var, change
//            Image(systemName: "checkmark.circle.fill")
//                .foregroundColor(.green)
//                .transition(.opacity)
            Label(text, systemImage: systemImage)
        }
    }
}

struct HeartView: View {
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
