//
//  HeartOverlayView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-01.
//
import SwiftUI

struct HeartOverlayView: View {
    let heartNums = 15
    
    var body: some View {
        ZStack {
            ForEach(0..<heartNums, id: \.self) { _ in
                Image(systemName: "heart.fill")
                    .foregroundColor(.white.opacity(0.15))
                    .font(.system(size: CGFloat.random(in: 40...160)))
                    .position(
                        x: CGFloat.random(in: 50...UIScreen.main.bounds.width - 50),
                        y: CGFloat.random(in: 100...UIScreen.main.bounds.height - 100)
                    )
            }
        }
    }
}
