//
//  AuthView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-30.
//

import SwiftUI
import SafariServices

struct OAuth2Resp: Decodable {
    var isAuth: Bool
    var email: String
    
    enum CodingKeys: String, CodingKey {
        case isAuth = "is_auth"
        case email
    }
}


struct AuthView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    private var gqlManager: GraphQLManager
    @State private var showSafariView = false
    @State private var urlToLoad: URL?
    @State private var ws: URLSessionWebSocketTask?
    
    init(gqlManager: GraphQLManager) {
        self.gqlManager = gqlManager
    }
    
    private func openWebSocket() {
        let session = URLSession(configuration: .default)
        let wsURL = URL(string: "ws://localhost:1919/ws-oauth2")!
        ws = session.webSocketTask(with: wsURL)
        print("ws conn opened")
    }
    
    func getOAuth2RedirectURL() {
        Task {
            do {
                let result: GraphQLData<RedirectURLResponse> = try await gqlManager.queryWithoutInputs(
                    queryName: "oauth2RedirectLink"
                )
                
                openWebSocket()
                guard let ws = ws else {
                    print("Failed to create websocket task")
                    return
                }
                ws.resume()
                
                if let url = URL(string: result.data.oauth2RedirectLink) {
                    await MainActor.run {
                        urlToLoad = url
                        showSafariView = true
                    }
                }
                
                
                while showSafariView {
                    let message = try await ws.receive()
                    
                    switch message {
                    case .string(let text):
                        print("string case")
                        if let data = text.data(using: .utf8) {
                            do {
                                let authStatus = try JSONDecoder().decode(OAuth2Resp.self, from: data)
                                if authStatus.isAuth {
                                    await MainActor.run {
                                        showSafariView = false
                                        authViewModel.setAuthorized(email: authStatus.email)
                                    }
                                }
                            } catch {
                                print("Failed to decode OAuth2Resp: \(error)")
                            }
                        }
                        break
                    case .data(_):
                        print("data case; invalid format as ws message")
                        break
                    @unknown default:
                        print("invalid format message received in ws")
                        break
                    }
                }
                
                print("ws conn closed")
                ws.cancel(with: URLSessionWebSocketTask.CloseCode.normalClosure, reason: nil)
                
            } catch {
                if let ws = ws {
                    ws.cancel(with: URLSessionWebSocketTask.CloseCode.normalClosure, reason: nil)
                }
                print("Error: \(error)")
            }
        }
    }
    
    var body: some View {
        HarmoniButton(title: "Google Sign In", action: getOAuth2RedirectURL)
            .sheet(
                isPresented: $showSafariView,
                onDismiss: {
                    if let ws = ws {
                        ws.cancel()
                        print("ws conn closed")
                    }
                }) {
                    if let url = urlToLoad {
                        SafariViewController(url: url)
                    }
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
