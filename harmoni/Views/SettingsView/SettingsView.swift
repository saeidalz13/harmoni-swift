//
//  SettingsView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-14.
//

import SwiftUI

struct SettingsView: View {
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    @State private var isLoading = false
    
    var body: some View {
        VStack {
        
            Button {
                Task {
                    await logOut()
                }
            } label: {
                RomanticLabelView(isLoading: $isLoading, text: "Log Out")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

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
