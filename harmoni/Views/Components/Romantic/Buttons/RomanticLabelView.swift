//
//  RomanticLabelView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-25.
//
import SwiftUI

/*
 TODO: Change this to Button
 1. Accept a closure
    - this closuer returns an struct of (Bool, Message)
    - after completion, popover that blurs the background (ZStack)
        - shows the Message (if true, mint popover else softPink popover)
 2. Adding a popover to this after completion
 */
struct RomanticLabelView: View {
    // TODO: Add a success binding variable to this
    @Binding var isLoading: Bool
    var text: String
    
    var systemImage: String?
    var linearGradient: LinearGradient = LinearGradient(
        colors: [
            Color.softPink,
            Color.teal.opacity(0.8)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    var verticalPadding: CGFloat = 10
    var horizontalPadding: CGFloat = 20
    var cornerRadius: CGFloat = 20
    var shadowColor: Color = .pink.opacity(0.15)
    
    let loadingLG = LinearGradient(colors: [.creamyLavender.opacity(0.4)], startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        LabelContent(isLoading: isLoading, text: text, systemImage: systemImage)
            .font(.custom("Avenir", size: 15))
            .fontWeight(.medium)
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


