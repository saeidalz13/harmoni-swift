//
//  AuthBackgroundView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-01.
//
import SwiftUI

struct HeartedBackgroundView: View {
    var selection: BackgroundViewSelection
    
    var body: some View {
        let gradientColors: [Color]
        
        switch selection {
        case .tabSelection(.auth) :
            gradientColors = [Color.pink.opacity(0.5), Color.teal.opacity(0.6)]
        case .tabSelection(.home):
            gradientColors = [Color.pink.opacity(0.5), Color.teal.opacity(0.5)]
//            gradientColors = [Color.purple.opacity(0.7), Color.pink.opacity(0.2)]
        case .tabSelection(.relationship):
            gradientColors = [Color.pink.opacity(0.9), Color.purple.opacity(0.6)]
        case .tabSelection(.finance):
            gradientColors = [Color.orange.opacity(0.8), Color.yellow.opacity(0.5)]
        case .tabSelection(.upkeep):
            gradientColors = [Color.green.opacity(0.8), Color.teal.opacity(0.6)]
        case .tabSelection(.settings):
            gradientColors = [Color.blue.opacity(0.8), Color.teal.opacity(0.6)]
        case .popover:
            gradientColors = [Color.pink.opacity(0.1), Color.teal.opacity(0.1)]
        }
        
        return LinearGradient(
            gradient: Gradient(colors: gradientColors),
            startPoint: .top,
            endPoint: .bottom
        )
        .overlay(HeartOverlayView())
    }
}
