//
//  AuthBackgroundView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-01.
//
import SwiftUI

enum TabSelection: Int8 {
    case auth
    case home
    case relationship
    case finance
    case upkeep
    case settings
}

struct BackgroundView: View {
    var selection: TabSelection
    
    var body: some View {
        let gradientColors: [Color]
        
        switch selection {
        case .auth:
            gradientColors = [Color.pink.opacity(0.5), Color.teal.opacity(0.6)]
        case .home:
            gradientColors = [Color.pink.opacity(0.4), Color.teal.opacity(0.4)]
//            gradientColors = [Color.purple.opacity(0.7), Color.pink.opacity(0.2)]
        case .relationship:
            gradientColors = [Color.pink.opacity(0.9), Color.purple.opacity(0.6)]
        case .finance:
            gradientColors = [Color.orange.opacity(0.8), Color.yellow.opacity(0.5)]
        case .upkeep:
            gradientColors = [Color.green.opacity(0.8), Color.teal.opacity(0.6)]
        case .settings:
            gradientColors = [Color.blue.opacity(0.8), Color.teal.opacity(0.6)]
        }
        
        return LinearGradient(
            gradient: Gradient(colors: gradientColors),
            startPoint: .top,
            endPoint: .bottom
        )
        .overlay(HeartOverlayView())
    }
}
