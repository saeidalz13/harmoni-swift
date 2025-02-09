//
//  ContentView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-25.
//
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var users: [LocalUser]
    
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
            
            // No user data in persisted store
            if users.isEmpty {
                AuthView()
                    .environment(authViewModel)
            } else {
                MainView().environment(authViewModel)
            }
        }
        .onAppear {
            authViewModel.setModelConext(modelContext: modelContext)
        }
    }
}

#Preview {
    ContentView()
}
