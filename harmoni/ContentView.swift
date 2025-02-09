//
//  ContentView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-25.
//
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context

    var graphQLManager: GraphQLManager
    var networkManager: NetworkManager

    @State private var authViewModel: AuthViewModel

    init() {
        networkManager = NetworkManager()
        graphQLManager = GraphQLManager()
        authViewModel = AuthViewModel(
            networkManager: networkManager,
            graphQLManager: graphQLManager
        )
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.white, .brown]),
                startPoint: .bottom,
                endPoint: .top
            ).ignoresSafeArea()
            
            if !authViewModel.getLoggedInStatus() {
                AuthView()
                    .environment(authViewModel)
            } else {
                MainView().environment(authViewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
