//
//  CookieOrOopsieView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-13.
//

import SwiftUI

struct SummaryMomentView: View {
    var num: Int
    var momentTag: MomentTag
    
    var body: some View {
        VStack {
            Text(momentTag == .cookie ? "🍪" : "❤️‍🩹")
                .font(.system(size: 30))
            
            Text("\(num)")
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.white.opacity(0.5))
        .cornerRadius(20)
        .shadow(color: momentTag == .cookie ? .green : .softPink, radius: 3)
        .contentShape(Rectangle())
        .hoverEffect(.highlight)
    }
}
