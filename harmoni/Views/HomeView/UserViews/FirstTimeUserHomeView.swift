//
//  BrandNewUserHomeView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-01.
//

import SwiftUI

struct FirstTimeUserHomeView: View {
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    @State private var newBondTitle = ""
    @State private var bondIdToJoin = ""
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            RomanticContainer {
                RomanticIntroView()
                    .padding(.vertical)
                
                VStack {
                    TextField("New Bond Title", text: $newBondTitle)
                        .padding(5)
                        .background(Color(.systemGray.withAlphaComponent(0.1)))
                        .cornerRadius(10)
                    
                    Button(action: {
                        Task {
                            try await localUserViewModel.createBond(bondTitle: newBondTitle)
                        }
                        
                    }) {
                        RomanticLabelView(
                            isLoading: $isLoading,
                            text: "Create",
                            systemImage: "plus.circle.fill"
                        )
                    }
                    .padding(.bottom, 10)
                    
                    Divider()
                    
                    TextField("Bond ID (from partner)", text: $bondIdToJoin)
                        .padding(5)
                        .background(Color(.systemGray.withAlphaComponent(0.1)))
                        .cornerRadius(10)
                    
                    Button {
                        Task {
                            try await localUserViewModel.joinBond(bondId: bondIdToJoin)
                        }
                    } label: {
                        RomanticLabelView(
                            isLoading: $isLoading,
                            text: "Join",
                            systemImage: "heart.fill"
                        )
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //        .padding(.top, 30)
        .background(backgroundView())
        .ignoresSafeArea()
    }
    
    private func backgroundView() -> some View {
        let gradientColors = [Color.orange.opacity(0.8), Color.teal.opacity(0.6)]
        return LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom)
            .overlay(heartOverlay())
    }
    
    private func heartOverlay() -> some View {
        ZStack {
            ForEach(0..<10, id: \.self) { _ in
                Image(systemName: "heart.fill")
                    .foregroundColor(.white.opacity(0.2))
                    .font(.system(size: CGFloat.random(in: 50...150)))
                    .position(
                        x: CGFloat.random(in: 50...UIScreen.main.bounds.width - 50),
                        y: CGFloat.random(in: 100...UIScreen.main.bounds.height - 100)
                    )
            }
        }
    }
}


struct RomanticIntroView: View {
    var body: some View {
        VStack(spacing: 24) {
            // Decorative elements
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.pink.opacity(0.7), Color.purple.opacity(0.5)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                    .blur(radius: 15)
                    .offset(x: -40, y: -10)
                
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.5)]),
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading
                        )
                    )
                    .frame(width: 100, height: 100)
                    .blur(radius: 15)
                    .offset(x: 50, y: 20)
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .shadow(color: .pink.opacity(0.5), radius: 10, x: 0, y: 0)
            }
            .frame(height: 150)
            
            // Poetic message
            VStack(spacing: 16) {
                Text("Harmonize Your Love")
                    .font(.system(size: 22, weight: .bold, design: .serif))
                    .foregroundColor(.primary)
                
                Text("""
                Create a bond between hearts,
                Where memories never fade.
                Share whispers, dreams, and thoughts,
                In this sanctuary you've made.
                """)
                .font(.system(size: 14, weight: .light, design: .serif))
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .lineSpacing(6)
            }
            
            HStack(spacing: 5) {
                ForEach(0..<3) { i in
                    Circle()
                        .fill(Color.pink.opacity(0.7))
                        .frame(width: 8, height: 8)
                        .scaleEffect(1 + 0.3 * sin(Double(i) * 0.5 + Date().timeIntervalSince1970))
                        .animation(
                            Animation.easeInOut(duration: 1.5)
                                .repeatForever()
                                .delay(Double(i) * 0.2),
                            value: Date().timeIntervalSince1970
                        )
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(.systemBackground))
                .shadow(color: Color.purple.opacity(0.2), radius: 15, x: 0, y: 5)
        )
        .padding(.horizontal, 5)
    }
}
