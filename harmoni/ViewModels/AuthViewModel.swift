//
//  AuthViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-30.
//
import SwiftUI
import SwiftData

@Observable
class AuthViewModel {
    private var isLoggedIn: Bool = false
    private var userId: String = ""
    private var email: String = ""
    private var networkManager: NetworkManager
    private var graphQLManager: GraphQLManager
    private var modelContext: ModelContext? = nil
    
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
    func setModelConext(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func setAuthorized(userId: String, email: String) {
        isLoggedIn = true
        self.userId = userId
        self.email = email
    }
    
    /*
     Getters
     */
    func getLoggedInStatus() -> Bool {
        return isLoggedIn
    }
    
    func getEmail() -> String {
        return email
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
                        let localUser = LocalUser(
                            id: oAuthResp.userId,
                            email: oAuthResp.email,
                            firstName: oAuthResp.firstName,
                            lastName: oAuthResp.lastName,
                            partnerID: oAuthResp.partnerId,
                            familyID: oAuthResp.familyId,
                            familyTitle: oAuthResp.familyTitle
                        )
                        
                        self.modelContext?.insert(localUser)
                        do {
                            try self.modelContext?.save()
                        } catch {
                            print("Failed to save user: \(error)")
                        }
                        
                        await MainActor.run {
                            showSafariView = false
                            setAuthorized(userId: oAuthResp.userId, email: oAuthResp.email)
                        }
                    }
                }
                
                networkManager.closeWebSocketConn(ws: ws)
            
            } catch {
                if let ws = ws {
                    networkManager.closeWebSocketConn(ws: ws)
                }
                alertMessage = "Sorry! Unable to sign in at this time"
                showAlert = true
                
                print("Failed Sign In Google: \(error)")
                
                await MainActor.run {
                    showSafariView = false
                }
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
