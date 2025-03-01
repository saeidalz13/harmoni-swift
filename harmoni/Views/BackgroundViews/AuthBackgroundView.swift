//
//  AuthBackgroundView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-01.
//
import SwiftUI

struct AuthBackgroundView: View {
    var body: some View {
        let gradientColors = [Color.orange.opacity(0.8), Color.teal.opacity(0.6)]
        return LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom)
            .overlay(HeartOverlayView())
    }
}
