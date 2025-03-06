//
//  RomanticLabelContent.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-04.
//
import SwiftUI

struct LabelContent: View {
    var isLoading: Bool
    var text: String
    var systemImage: String?
    
    var body: some View {
        ZStack {
            if isLoading {
                HStack(spacing: 0.1) {
                    OrbitingHeartsView(mainHeartSize: 25, orbitingHeartSize: 20, orbitRadius: 15)
                }
            } else {
                if let systemImage {
                    Label(text, systemImage: systemImage)
                } else {
                    Text(text)
                }
            }
        }
        .frame(minWidth: calculateMinWidth(), minHeight: calculateMinHeight())
    }
    
    private func calculateMinWidth() -> CGFloat {
        // Estimate width based on text length and system image presence
        let baseWidth: CGFloat = systemImage != nil ? 30 : 0
        let textWidth = CGFloat(text.count) * 8 // Rough estimate
        let loadingWidth: CGFloat = 60 // Approximate width of OrbitingHeartsView
        
        return max(baseWidth + textWidth, loadingWidth)
    }
    
    private func calculateMinHeight() -> CGFloat {
        let textHeight: CGFloat = 20 // Approximate height of text/label
        let loadingHeight: CGFloat = 30 // Approximate height of OrbitingHeartsView
        
        return max(textHeight, loadingHeight)
    }
}
