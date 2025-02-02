//
//  AuthViewModel.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-30.
//
import SwiftUI

@Observable
class AuthViewModel {
    // Since we're using Observable decorator
    // we get @published automatically for
    // every variable
    private var isLoggedIn: Bool = false
    private var email: String = ""
    
    func setAuthorized(email: String) {
        isLoggedIn = true
        self.email = email
    }
    
    func getLoggedInStatus() -> Bool {
        return isLoggedIn
    }
}
