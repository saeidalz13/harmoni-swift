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
        let gqlData = try await GraphQLManager.shared.execQuery(
            query: GraphQLQuery.authenticateIdToken,
            input: AuthenticateIdTokenInput.init(
                idToken: idToken
            ),
            withBearer: false
        ) as AuthenticateIdTokenResponse
        
        guard let authPayload = gqlData.authenticateIdToken else {
            throw GraphQLError.unavailableData(queryName: "authenticateIdToken")
        }
        
        try KeychainManager.shared.saveTokensToKeychain(
            accessToken: authPayload.accessToken,
            refreshToken: authPayload.refreshToken
        )
        
        self.isAuth = true
        self.email = email
        self.isLoading = false
        
        let isHarmoniFirstTimeUserStr = KeychainManager.shared.retrieveFromKeychain(
            key: KeychainKey.isHarmoniFirstTimeUser
        )
        self.isHarmoniFirstTimeUser = isHarmoniFirstTimeUserStr == nil
    }
    
    func markUserAsOnboarded() throws {
        try KeychainManager.shared.saveToKeychain(token: "onboarded", key: .isHarmoniFirstTimeUser)
        self.isHarmoniFirstTimeUser = false
    }
    
    func logOutBackend() {
        KeychainManager.shared.removeTokensFromKeychain()
        
        // TODO: Delete this line later
        KeychainManager.shared.removeTokenByKey(key: .isHarmoniFirstTimeUser)
        
        GIDSignIn.sharedInstance.signOut()
        
        isAuth = false
        email = ""
    }
    
}
