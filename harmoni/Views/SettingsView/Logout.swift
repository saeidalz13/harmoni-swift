//
//  Logout.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-13.
//

import SwiftUI
import GoogleSignIn

struct Logout: View {
    @Environment(AuthViewModel.self) private var authViewModel
    
    var body: some View {
        Button("Logout") {
            GIDSignIn.sharedInstance.signOut()
            authViewModel.localUser = nil
        }
        .cornerRadius(10)
        .padding()
        .background(.black)
        .foregroundStyle(.white)
    }
}
