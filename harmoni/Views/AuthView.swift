//
//  AuthView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-30.
//

import SwiftUI
import SafariServices



struct AuthView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    
    var body: some View {
        @Bindable var authViewModel = authViewModel
        
        HarmoniButton(title: "Google Sign In", action: authViewModel.signInOAuth2Google)
            .sheet(
                isPresented: $authViewModel.showSafariView,
                onDismiss: {
                    if let ws = authViewModel.getWsObject() {
                        ws.cancel()
                        print("ws conn closed")
                    }
                }) {
                    if let url = authViewModel.redirectURL {
                        SafariViewController(url: url)
                    }
                }
                .alert("Error", isPresented: $authViewModel.showAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(authViewModel.alertMessage)
                }
    }
}

// Helper View to wrap SFSafariViewController for SwiftUI
struct SafariViewController: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariViewController>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariViewController>) {
    }
}
