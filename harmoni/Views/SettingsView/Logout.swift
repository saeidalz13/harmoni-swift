//
//  Logout.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-13.
//

import SwiftUI

struct Logout: View {
    @Environment(AuthViewModel.self) private var authViewModel
    
    var body: some View {
        Button("Logout") {
            Task {
                await logOut()
            }
        }
        .cornerRadius(10)
        .padding()
        .background(.black)
        .foregroundStyle(.white)
    }
    
    private func logOut() async {
        do {
            try await authViewModel.logOutBackend()
        }
        catch {
            print(error)
        }
        

    }
}
