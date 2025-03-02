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
            if authViewModel.isLoading {
                TransitionLoadingView()
            }
            
            if !authViewModel.isLoading && authViewModel.isAuth {
                MainView()
                
            }
            
            if !authViewModel.isLoading && !authViewModel.isAuth {
                AuthView()
            }
        }
    }
}

