//
//  TransitionLoadingView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-02.
//

import SwiftUI
import Combine

struct TransitionLoadingView: View {
    @State private var opacity: Double = 0.7
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    @State private var timer: AnyCancellable?
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.5)
            
            VStack(spacing: 5) {
                Text("🍃")
                    .font(.system(size: 45))
                    .opacity(opacity)
                    .offset(x: offsetX, y: offsetY)
                    .onAppear {
                        // Opacity Animation
                        withAnimation(.easeInOut(duration: 1).repeatForever()) {
                            opacity = 0.8
                        }
                        
                        timer = Timer.publish(every: 0.5, on: .main, in: .common)
                            .autoconnect()
                            .sink { _ in
                                withAnimation(.easeInOut(duration: 1.5)) {
                                    offsetX = CGFloat.random(in: -25...25)
                                    offsetY = CGFloat.random(in: -25...25)
                                }
                            }
                    }
                
                Text("Harmoni...")
                    .font(.custom("Zapfino", size: 30))
                    .fontWeight(.semibold)
            }
        }
        .background(BackgroundView(selection: .auth))
        .edgesIgnoringSafeArea(.all)
        .onDisappear {
            timer?.cancel()
        }
    }
}

