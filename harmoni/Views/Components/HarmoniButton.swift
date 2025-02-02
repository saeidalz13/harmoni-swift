//
//  HarmoniButton.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-26.
//
import SwiftUI

struct HarmoniButton: View {
    let title: String
    let backgroundColor: Color
    let width: CGFloat
    let height: CGFloat
    let action: () -> Void

    // Provide default values for backgroundColor, width, and height
    init(
        title: String,
        backgroundColor: Color = .black,
        width: CGFloat = 150,
        height: CGFloat = 60,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.width = width
        self.height = height
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: width, height: height) // Set width and height here
                .background(backgroundColor)
                .cornerRadius(10)
        }
    }
}
