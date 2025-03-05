//
//  SettingsView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-14.
//

import SwiftUI

struct SettingsView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            
            Button {
                Task {
                    do {
                        try await authViewModel.logOutBackend()
                    } catch {
                        print(error)
                    }
                }
                

            } label: {
                RomanticLabelView(isLoading: $isLoading, text: "Log Out")
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

    }
}
