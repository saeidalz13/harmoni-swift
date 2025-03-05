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
        
        guard let authPayload = gqlData.authenticateIdToken else {
            throw GraphQLError.unavailableData(queryName: GraphQLOperationBuilder.authenticateBackend.operationName)
        }
        
        try KeychainManager.shared.saveTokensToKeychain(
            accessToken: authPayload.accessToken,
            refreshToken: authPayload.refreshToken
        )
        
        self.isAuth = true
        self.email = email
        
        let isHarmoniFirstTimeUserStr = KeychainManager.shared.retrieveFromKeychain(
            key: KeychainKey.isHarmoniFirstTimeUser
        )
        self.isHarmoniFirstTimeUser = isHarmoniFirstTimeUserStr == nil
        self.isLoading = false
    }
    
    func markUserAsOnboarded() throws {
        try KeychainManager.shared.saveToKeychain(token: "onboarded", key: .isHarmoniFirstTimeUser)
        self.isHarmoniFirstTimeUser = false
    }
    
    func logOutBackend() async throws {
        // TODO: send backend logout
//        let _ = try await GraphQLManager.shared.execOperation(
//            GraphQLOperation.logOut,
//            variables: LogOutInput(logOut: <#T##UserIdResponse?#>)
//        )
//        
        KeychainManager.shared.removeTokensFromKeychain()
        
        // TODO: Delete this line later
        KeychainManager.shared.removeTokenByKey(key: .isHarmoniFirstTimeUser)
        
        GIDSignIn.sharedInstance.signOut()
        
        isAuth = false
        email = ""
    }
    
}
