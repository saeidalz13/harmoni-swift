//
//  RomanticContainer.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-27.
//

import SwiftUI

struct RomanticContainer<Content: View>: View {
    let content: Content
    var width: CGFloat?
    var height: CGFloat?
    var backgroundColor: Color
    var verticalPadding: CGFloat
    var horizontalPadding: CGFloat
    
    init(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        backgroundColor: Color = .white.opacity(0.9),
        verticalPadding: CGFloat = 30,
        horizontalPadding: CGFloat = 20,
        @ViewBuilder content: () -> Content
    ) {
        self.width = width
        self.height = height
        self.backgroundColor = backgroundColor
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .frame(width: width, height: height)
        .padding(.vertical, verticalPadding)
        .padding(.horizontal, horizontalPadding)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
                .shadow(color: Color.pink.opacity(0.25), radius: 10, x: 0, y: 15) // shadow ☁️💖
        )
        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: width) // Smooth animation
        .transition(.scale)
    }
}
