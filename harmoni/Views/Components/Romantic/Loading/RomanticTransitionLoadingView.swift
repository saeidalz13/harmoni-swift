//
//  TransitionLoadingView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-02.
//

import SwiftUI
import Combine

struct RomanticTransitionLoadingView: View {
    @State private var opacity: Double = 0.7
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    @State private var timer: AnyCancellable?
    
    @State private var size: CGFloat = 45
    private let baseSize: CGFloat = 45
    
    @State private var dotCount = 0
    @State private var dots: [Double] = [0, 0, 0]

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.5)
            
            VStack(spacing: 5) {
                OrbitingHeartsView()
                    .previewLayout(.sizeThatFits)

                HStack(spacing: 1) {
                    Text("Loading your love story")
                        .font(.avenirTitle)
                        .fontWeight(.semibold)

                    HStack(spacing: 2) {
                        ForEach(0..<3) { index in
                            Text(".")
                                .font(.avenirTitle)
                                .fontWeight(.semibold)
                                .opacity(dots[index])
                        }
                    }
                }
                .padding(.top, 15)
            }
        }
        .background(HeartedBackgroundView(selection: .tabSelection(.auth)))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            // Start the timer for animating dots
            timer = Timer.publish(every: 0.55, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    withAnimation(.easeIn(duration: 0.2)) {
                        dots[dotCount] = 1.0
                    }
                    
                    dotCount = (dotCount + 1) % 3
                    
                    // If we're back to the first dot, reset all dots
                    if dotCount == 0 {
                        // Small delay before resetting
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.easeOut(duration: 0.2)) {
                                dots = [0, 0, 0]
                            }
                        }
                    }
                }
        }
        .onDisappear {
            timer?.cancel()
        }
    }
}


//struct TransitionLoadingView: View {
//    // Animation states
//    @State private var heartScale: CGFloat = 1.0
//    @State private var heartRotation: Double = 0
//    @State private var opacity: Double = 0.8
//    @State private var glowOpacity: Double = 0
//    @State private var timer: AnyCancellable?
//    
//    // Floating elements
//    @State private var floatingElements: [FloatingElement] = []
//    
//    // Custom colors
//    let warmPink = Color(red: 0.95, green: 0.4, blue: 0.6)
//    let softPurple = Color(red: 0.65, green: 0.4, blue: 0.85)
//    
//    var body: some View {
//        ZStack {
//            // Gradient background
//            LinearGradient(
//                gradient: Gradient(colors: [
//                    Color.black.opacity(0.8),
//                    softPurple.opacity(0.3),
//                    warmPink.opacity(0.3)
//                ]),
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .edgesIgnoringSafeArea(.all)
//            
//            // Floating elements in background
//            ForEach(floatingElements) { element in
//                Text(element.symbol)
//                    .font(.system(size: element.size))
//                    .foregroundColor(Color.white.opacity(element.opacity))
//                    .position(element.position)
//                    .rotationEffect(.degrees(element.rotation))
//            }
//            
//            // Main content
//            VStack(spacing: 15) {
//                // Heart with pulsing animation
//                ZStack {
//                    // Glow effect
//                    Image(systemName: "heart.fill")
//                        .font(.system(size: 75))
//                        .foregroundColor(warmPink)
//                        .blur(radius: 20)
//                        .opacity(glowOpacity)
//                    
//                    // Main heart
//                    Image(systemName: "heart.fill")
//                        .font(.system(size: 65))
//                        .foregroundStyle(
//                            LinearGradient(
//                                colors: [warmPink, softPurple],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            )
//                        )
//                }
//                .scaleEffect(heartScale)
//                .rotationEffect(.degrees(heartRotation))
//                
//                // App name with elegant font
//                Text("Harmoni")
//                    .font(.custom("Zapfino", size: 36))
//                    .fontWeight(.medium)
//                    .foregroundColor(.white)
//                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
//                    .opacity(opacity)
//                
//                // Romantic tagline
//                Text("Connecting hearts, one moment at a time")
//                    .font(.system(.body, design: .serif))
//                    .italic()
//                    .foregroundColor(.white.opacity(0.8))
//                    .padding(.top, 5)
//                    .opacity(opacity)
//            }
//        }
//        .onAppear {
//            startAnimations()
//            generateFloatingElements()
//        }
//        .onDisappear {
//            timer?.cancel()
//        }
//    }
//    
//    // Animation configuration
//    private func startAnimations() {
//        // Heart pulse animation
//        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
//            heartScale = 1.15
//            glowOpacity = 0.7
//        }
//        
//        // Subtle heart rotation
//        withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
//            heartRotation = 5
//        }
//        
//        // Text fade in/out
//        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
//            opacity = 1.0
//        }
//    }
//    
//    // Generate floating romantic elements
//    private func generateFloatingElements() {
//        let screenWidth = UIScreen.main.bounds.width
//        let screenHeight = UIScreen.main.bounds.height
//        
//        let symbols = ["✨", "💫", "🌟", "♥️", "🌸", "✨"]
//        
//        for _ in 0..<15 {
//            let newElement = FloatingElement(
//                id: UUID(),
//                symbol: symbols.randomElement() ?? "✨",
//                position: CGPoint(
//                    x: CGFloat.random(in: 0...screenWidth),
//                    y: CGFloat.random(in: 0...screenHeight)
//                ),
//                size: CGFloat.random(in: 10...25),
//                opacity: Double.random(in: 0.3...0.7),
//                rotation: Double.random(in: 0...360)
//            )
//            floatingElements.append(newElement)
//        }
//        
//        // Animate floating elements
//        timer = Timer.publish(every: 0.1, on: .main, in: .common)
//            .autoconnect()
//            .sink { _ in
//                withAnimation(.easeInOut(duration: 3)) {
//                    for index in floatingElements.indices {
//                        floatingElements[index].position.y -= 1
//                        floatingElements[index].rotation += 0.5
//                        
//                        // Reset if element goes off screen
//                        if floatingElements[index].position.y < -50 {
//                            floatingElements[index].position.y = screenHeight + 50
//                            floatingElements[index].position.x = CGFloat.random(in: 0...screenWidth)
//                        }
//                    }
//                }
//            }
//    }
//}
//
//// Model for floating elements
//struct FloatingElement: Identifiable {
//    let id: UUID
//    let symbol: String
//    var position: CGPoint
//    let size: CGFloat
//    let opacity: Double
//    var rotation: Double
//}
//
//// Preview provider for SwiftUI canvas
//struct TransitionLoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransitionLoadingView()
//    }
//}
