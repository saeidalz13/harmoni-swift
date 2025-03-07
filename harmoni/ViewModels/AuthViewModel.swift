//
//  AuthViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-01.
//
import SwiftUI
import GoogleSignIn

@Observable @MainActor
final class AuthViewModel {
    private var _isAuth: Bool = false
    private var _isHarmoniFirstTimeUser = false
    private var _email = ""
    
    var isLoading = true
    
    var isAuth: Bool {
        get { return _isAuth }
        set { _isAuth = newValue }
    }
    var isHarmoniFirstTimeUser: Bool {
        get { return _isHarmoniFirstTimeUser }
        set { _isHarmoniFirstTimeUser = newValue }
    }
    var email : String? {
        get { return _email == "" ? nil : _email }
        set { _email = newValue ?? "" }
    }
    
    func authenticateBackend(idToken: String, email: String) async throws {
        let gqlData = try await GraphQLManager.shared.execOperation(
            GraphQLOperationBuilder.authenticateBackend.build(),
            variables: AuthenticateIdTokenVariables(
                authenticateIdTokenInput: AuthenticateIdTokenInput.init(
                    idToken: idToken
                )
            ),
            withBearer: false
        ) as AuthenticateIdTokenResponse
        
        let loadingStartTime = Date()
        
        guard let authPayload = gqlData.authenticateIdToken else {
            throw GraphQLError.unavailableData(queryName: GraphQLOperationBuilder.authenticateBackend.operationName)
        }
        
        try KeychainManager.shared.saveTokensToKeychain(
            accessToken: authPayload.accessToken,
            refreshToken: authPayload.refreshToken
        )
        
        signInUser(loadingStartTime: loadingStartTime, email: email)
    }
    
    func markUserAsOnboarded() throws {
        try KeychainManager.shared.saveToKeychain(token: "onboarded", key: .isHarmoniFirstTimeUser)
        self.isHarmoniFirstTimeUser = false
    }
    
    func logOutBackend() async throws {
        // TODO: send backend logout
        let _ = try await GraphQLManager.shared.execOperation(
            GraphQLOperationBuilder.logOut.build(),
            variables: nil as String?,
            withBearer: true
        ) as LogOutResponse
        
        signOutClient()
    }
    
    func signOutClient() {
//        KeychainManager.shared.removeTokenByKey(key: .isHarmoniFirstTimeUser)
        KeychainManager.shared.removeTokensFromKeychain()
        GIDSignIn.sharedInstance.signOut()
        isAuth = false
        email = ""
    }
    
    func signInUser(loadingStartTime: Date, email: String) {
        self.isAuth = true
        self.email = email
        
        let isHarmoniFirstTimeUserStr = KeychainManager.shared.retrieveFromKeychain(
            key: KeychainKey.isHarmoniFirstTimeUser
        )
        self.isHarmoniFirstTimeUser = isHarmoniFirstTimeUserStr == nil
        
        finishLoadingWithMinimumTime(loadingStartTime: loadingStartTime, minimumTime: 1) {
            self.isLoading = false
        }
    }
    
    func authTokensExistInKeychain() -> Bool {
        let accessToken = KeychainManager.shared.retrieveFromKeychain(key: KeychainKey.accessToken)
        let refreshToken = KeychainManager.shared.retrieveFromKeychain(key: KeychainKey.refreshToken)
        
        if accessToken != nil && refreshToken != nil {
            return true
        }
        
        isLoading = false
        return false
    }
    
    private func finishLoadingWithMinimumTime(loadingStartTime: Date, minimumTime: TimeInterval, completion: @escaping () -> Void) {
        let elapsedTime = Date().timeIntervalSince(loadingStartTime)
        let remainingTime = max(0, minimumTime - elapsedTime)
        
        if remainingTime > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + remainingTime) {
                completion()
            }
        } else {
            // Minimum time already elapsed, execute immediately
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
}
