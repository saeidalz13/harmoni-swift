//
//  AuthViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-30.
//
import SwiftUI

@Observable
class AuthViewModel {
    private var isLoggedIn: Bool = false
    private var userID: String = ""
    private var networkManager: NetworkManager
    private var graphQLManager: GraphQLManager
    
    private var ws: URLSessionWebSocketTask?
    var showAlert = false
    var redirectURL: URL?
    var alertMessage = ""
    var showSafariView = false
    
    init(networkManager: NetworkManager, graphQLManager: GraphQLManager) {
        self.networkManager = networkManager
        self.graphQLManager = graphQLManager
    }
    
    /*
     Setters
     */
    func setAuthorized(userID: String) {
        isLoggedIn = true
        self.userID = userID
    }
    
    /*
     Getters
     */
    func getLoggedInStatus() -> Bool {
        return isLoggedIn
    }
    
    func getUserID() -> String {
        return userID
    }
    
    func getWsObject() -> URLSessionWebSocketTask? {
        return ws
    }
    
    func signInOAuth2Google() {
        Task {
            do {
                let oauth2RedirectLink = try await queryGoogleOAuth2RedirectLink()
                
                if let url = URL(string: oauth2RedirectLink) {
                    await MainActor.run {
                        redirectURL = url
                        showSafariView = true
                    }
                }
                
                let ws = networkManager.newWebSocketTask()
                
                while showSafariView {
                    let data = try await networkManager.getWebSocketMessage(ws: ws)
                    let oAuthResp = try DataSerializer.decodeJSON(data: data) as OAuth2RestResponse
                    
                    if oAuthResp.isAuth {
                        await MainActor.run {
                            showSafariView = false
                            setAuthorized(userID: oAuthResp.userId)
                        }
                    }
                }
                
                networkManager.closeWebSocketConn(ws: ws)
            
            } catch {
                await MainActor.run {
                    showSafariView = false
                }
                
                if let ws = ws {
                    ws.cancel(with: URLSessionWebSocketTask.CloseCode.normalClosure, reason: nil)
                }
                alertMessage = "Sorry! Unable to sign in at this time"
                showAlert = true
                
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    /*
     Private Functions
     */
    private func queryGoogleOAuth2RedirectLink() async throws -> String {
        let httpBody = try graphQLManager.queryWithoutInputsHTTPBody(
            queryName: "oauth2RedirectLink"
        )
        let request = networkManager.createPostRequest(httpBody: httpBody)
        let responseData = try await networkManager.makeHTTPRequest(request: request)
        let encodedResponseData = try JSONDecoder().decode(GraphQLData<OAuth2RedirectLinkResponse>.self, from: responseData)
        
        return encodedResponseData.data.oauth2RedirectLink
    }
}
