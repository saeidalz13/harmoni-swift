//
//  Logout.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-13.
//

import SwiftUI

struct Logout: View {
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    
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
            try await localUserViewModel.logOutBackend()
        }
        catch {
            print(error)
        }
        

    }
}
