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
    private var _isFirstTimeUser = false
    private var _email = ""
    
    var isLoading = true
    
    var isAuth: Bool {
        get { return _isAuth }
        set { _isAuth = newValue }
    }
    var isHarmoniFirstTimeUser: Bool {
        get { return _isFirstTimeUser }
        set { _isFirstTimeUser = newValue }
    }
    var email : String? {
        get { return _email == "" ? nil : _email }
        set { _email = newValue ?? "" }
    }
    
    func authenticateBackend(idToken: String) async throws {
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
        
        isAuth = true
        email = authPayload.user.email
        
        let isHarmoniFirstTimeUserStr = KeychainManager.shared.retrieveFromKeychain(
            key: KeychainKey.isHarmoniFirstTimeUser
        )
        isHarmoniFirstTimeUser = isHarmoniFirstTimeUserStr == nil
        
        // TODO: This should be where user completed initial info
//        if isHarmoniFirstTimeUser {
//            print("first time")
//            try KeychainManager.shared.saveToKeychain(token: "onboarded", key: .isHarmoniFirstTimeUser)
//        }
    }
    
    func logOutBackend() {
        KeychainManager.shared.removeTokensFromKeychain()
        KeychainManager.shared.removeTokenByKey(key: .isHarmoniFirstTimeUser)
        GIDSignIn.sharedInstance.signOut()
        
        isAuth = false
        email = ""
    }
    
}
