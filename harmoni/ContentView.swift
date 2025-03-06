//
//  ContentView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-25.
//
import SwiftUI

struct ContentView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    @State var homeVM: HomeViewModel = .init()
    @State var userVM: UserViewModel = .init()
    
    var body: some View {
        ZStack {
            if authViewModel.isLoading {
                RomanticTransitionLoadingView()
            }
            
            if !authViewModel.isLoading && authViewModel.isAuth {
                MainView()
                    .environment(homeVM)
                    .environment(userVM)
            }
            
            if !authViewModel.isLoading && !authViewModel.isAuth {
                AuthView()
            }
        }
    }
}

