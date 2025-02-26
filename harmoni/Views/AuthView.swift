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
    @Environment(LocalUserViewModel.self) private var authViewModel
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Button("Google Sign In", systemImage: "envelope.open.fill") {
                handleSignInButton()
            }
            .cornerRadius(10)
            .padding()
            .background(.black)
            .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.maroon)
        
        .alert("Error", isPresented: $showAlert) {
            Button("Dimiss", role: .cancel) {}
        } message: {
            Text("Failed to Sign In!")
        }
    }
    
    func handleSignInButton() {
        guard let presentingViewController = (
            UIApplication.shared.connectedScenes.first
            as? UIWindowScene
        )?.windows.first?.rootViewController
        else {return}
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            guard let result = signInResult else {
                print(error?.localizedDescription ?? "Failed to sign in with Google")
                return
            }
            
            guard let idToken = result.user.idToken else {
                print("No id token was found in Google payload")
                return
            }
            
            Task {
                await authViewModel.authenticateBackend(idToken: idToken.tokenString)
            }

        }
    }

}

