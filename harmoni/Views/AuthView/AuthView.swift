//
//  AuthView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-30.
//

import SwiftUI
import SwiftData
import GoogleSignIn


struct AuthView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    @State private var showAlert: Bool = false
    @State private var isLoadingGoogleSignIn = false
    @State private var currentSlide = 0
    @State private var opacity: Double = 0  // Add a state for opacity
    private let slidesNum = 2
    
    var body: some View {
        VStack {
            RomanticContainer(backgroundColor: .white.opacity(0.55)) {
                Text("Harmoni 🍃")
                    .font(.custom("Zapfino", size: 30))
                    .fontWeight(.semibold)
                    .foregroundStyle(
                        LinearGradient(colors: [.black],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)
                    )
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 1)
                    .padding(3)
                
                // Only the slide content changes
                ZStack {
                    AuthViewSlideOne()
                        .opacity(currentSlide == 0 ? 1 : 0)
                        .padding(.bottom, 20)
                    
                    AuthViewSlideLast()
                        .opacity(currentSlide == slidesNum-1 ? 1 : 0)
                        .padding(.bottom, 20)
                }
                
                // Pagination indicators
                HStack(spacing: 8) {
                    ForEach(0..<slidesNum, id: \.self) { index in
                        Circle()
                            .fill(currentSlide == index ? Color.black : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                            .onTapGesture {
                                withAnimation {
                                    currentSlide = index
                                }
                            }
                    }
                }
                .padding(.bottom, 20)
                
                Divider()
                    .frame(maxWidth: 180)
                    .padding(.bottom, 15)
                
                Button {
                    isLoadingGoogleSignIn = true
                    do {
                        try handleSignInButton()
                    } catch {
                        showAlert = true
                        print("Authorization failed: \(error.localizedDescription)")
                        KeychainManager.shared.removeTokensFromKeychain()
                        GIDSignIn.sharedInstance.signOut()
                    }
                    authViewModel.isLoading = false
                    isLoadingGoogleSignIn = false
                    
                } label: {
                    RomanticLabelView(
                        isLoading: $isLoadingGoogleSignIn,
                        text: "Google Sign In",
                        systemImage: "envelope.open.fill",
                        linearGradient: LinearGradient(colors: [.black], startPoint: .top, endPoint: .bottom),
                        verticalPadding: 15
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundView(selection: .auth))
        .ignoresSafeArea()
        .opacity(opacity)
        .gesture(
            DragGesture()
                .onEnded { gesture in
                    let threshold: CGFloat = 50
                    if gesture.translation.width > threshold {
                        // Slide right to left (show previous)
                        withAnimation {
                            currentSlide = max(0, currentSlide - 1)
                        }
                    } else if gesture.translation.width < -threshold {
                        // Slide left to right (show next)
                        withAnimation {
                            currentSlide = min(slidesNum - 1, currentSlide + 1)
                        }
                    }
                }
        )
        .onAppear {
            withAnimation(.easeIn(duration: 0.5)) {
                opacity = 1
            }
        }
        .onDisappear {
            opacity = 0
        }
        
        .alert("Error", isPresented: $showAlert) {
            Button("Dimiss", role: .cancel) {}
        } message: {
            Text("Failed to Sign In!")
        }
    }
    
    
    // TODO: Take the whole thing to ViewModel
    func handleSignInButton() throws {
        guard let presentingViewController = (
            UIApplication.shared.connectedScenes.first
            as? UIWindowScene
        )?.windows.first?.rootViewController
        else {return}
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) {
            signInResult,
            error in
            if let e = error {
                print("Failed to sign in with Google: \(e.localizedDescription)")
                return
            }
            
            guard let result = signInResult else {
                print(error?.localizedDescription ?? "Failed to sign in with Google")
                return
            }
            
            guard let idToken = result.user.idToken else {
                print("No id token was found in Google payload")
                return
            }
            
            guard let profile = result.user.profile else { return }
            
            Task {
                do {
                    try await authViewModel.authenticateBackend(
                        idToken: idToken.tokenString,
                        email: profile.email
                    )
                } catch {
                    throw error
                }
                
            }
        }
    }

}

