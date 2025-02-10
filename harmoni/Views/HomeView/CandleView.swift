//
//  CandleView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-09.
//

import SwiftUI

struct CandleView: View {
    var text: String 
    @State private var verticalFlameOffset: CGFloat = 40
    @State private var horizontalFlameOffset: CGFloat = 20
    
    var body: some View {
        ZStack {
            // Candle Body
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.6))
                .frame(width: 100, height: 120)
                .shadow(color: .orange, radius: 10)

            // Text inside the candle
            Text(text)
                .font(.caption)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .frame(width: 50, height: 130)

            // Flame
            Ellipse()
                .fill(Color.orange)
                .frame(width: horizontalFlameOffset, height: verticalFlameOffset)
                .offset(y: -70)
                .onAppear {
                    startFlameAnimation()
                }
        }
    }
    
    private func startFlameAnimation() {
        withAnimation(
            Animation.easeInOut(duration: 0.5)
                .repeatForever(autoreverses: true)
        ) {
            verticalFlameOffset = 50
            horizontalFlameOffset = 22
        }
    }
}
