//
//  AuthViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-01.
//
import SwiftUI
import GoogleSignIn

@Observable
final class AuthViewModel {
    private var _isAuth: Bool = false
    private var _isFirstTimeUser = false
    private var _email = ""
    
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
        if isHarmoniFirstTimeUser {
            try KeychainManager.shared.saveToKeychain(token: "onboarded", key: .isHarmoniFirstTimeUser)
        }
        
    }
    
}
