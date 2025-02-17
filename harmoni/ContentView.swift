//
//  ContentView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-25.
//
import SwiftUI

struct ContentView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    
    var body: some View {
        ZStack {
            if authViewModel.localUser != nil {
                MainView()
                    .environment(authViewModel)
            } else {
                AuthView()
                    .environment(authViewModel)
            }
        }
    }
}

