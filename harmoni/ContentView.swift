//
//  ContentView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-25.
//
import SwiftUI

struct ContentView: View {
    @State private var authViewModel = AuthViewModel()
    @State private var gqlManager = GraphQLManager()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.white, .brown]),
                startPoint: .bottom,
                endPoint: .top
            ).ignoresSafeArea()
            
            if !authViewModel.getLoggedInStatus() {
                AuthView(gqlManager: gqlManager).environment(authViewModel)
            } else {
                MainView()
            }
        }
    }
}

#Preview {
    ContentView()
}
