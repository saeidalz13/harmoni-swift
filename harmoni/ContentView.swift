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
    var test = true
    
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
            if users.isEmpty && !test {
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
    
//    #if DEBUG
//    #else
//    #endif
    
}

#Preview {
    ContentView()
}
