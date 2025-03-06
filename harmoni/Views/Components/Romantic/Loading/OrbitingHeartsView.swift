//
//  OrbitingHeartsView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-05.
//

import SwiftUI

struct OrbitingHeartsView: View {
    var mainHeartSize: CGFloat
    var orbitingHeartSize: CGFloat
    var orbitRadius: CGFloat
    
    init(
        mainHeartSize: CGFloat = 120,
        orbitingHeartSize: CGFloat = 80,
        orbitRadius: CGFloat = 90
    ) {
        self.mainHeartSize = mainHeartSize
        self.orbitingHeartSize = orbitingHeartSize
        self.orbitRadius = orbitRadius
    }
    
    let animationDuration: Double = 4.0
    
    @State private var animationPhase: Double = 0
    
    var body: some View {
        TimelineView(.animation) { timeline in
            // Calculate the current angle based on the current date
            // This provides smooth continuous animation
            let date = timeline.date
            let angle = animationPhase + date.timeIntervalSinceReferenceDate.remainder(dividingBy: animationDuration) / animationDuration * 2 * .pi
            
            ZStack {
                // Position based on z-index to handle occlusion
                if sin(angle) < 0 {
                    orbitingHeartView(angle: angle)
                    mainHeartView
                } else {
                    mainHeartView
                    orbitingHeartView(angle: angle)
                }
            }
        }
    }
    
    // Main heart view
    private var mainHeartView: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: mainHeartSize, height: mainHeartSize)
            .foregroundColor(.pink.opacity(0.8))
    }
    
    // Orbiting heart view with size and position variations
    private func orbitingHeartView(angle: Double) -> some View {
        // Calculate scale and opacity factors based on the sine of the angle
        let scaleFactor = 0.7 + 0.3 * (1 + sin(angle)) / 2
        let opacityFactor = 0.7 + 0.3 * (1 + sin(angle)) / 2
        let shadowIntensity = 0.2 * (1 + sin(angle)) / 2
        
        return Image(systemName: "heart.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(
                width: orbitingHeartSize * scaleFactor,
                height: orbitingHeartSize * scaleFactor
            )
            .opacity(opacityFactor)
            .offset(
                x: cos(angle) * orbitRadius,
                y: 0
            )
            .foregroundColor(Color.softPink)
            .shadow(
                color: .black.opacity(shadowIntensity),
                radius: 5,
                x: 0,
                y: 2
            )
    }
}
