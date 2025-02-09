//
//  HomeView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-01.
//
import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    @Query private var users: [LocalUser]
    
    var body: some View {
        ZStack {
        
            VStack {
                HStack{
                    if let user = users.first {
                        Text("Welcome, \(user.email)")
                    } else {
                        Text("No user found.")
                    }
                }
                
                HStack {
                    Text("Relationship Health Check Section")
                }
                
                HStack {
                    Text("Relationship Stuff Section")
                }
                
                HStack {
                    Text("Finance Section")
                }
            }

        }
    }
}

//            LinearGradient(
//                gradient: Gradient(colors: [
//                    Color(red: 0.05, green: 0.05, blue: 0.2),  // Dark navy blue
//                    Color(red: 0.5, green: 0.3, blue: 0.1),   // Warm brown
//                    Color(red: 0.82, green: 0.52, blue: 0.24) // Goldenrod
//                ]),
//                startPoint: .top,
//                endPoint: .bottom
//            )
//            .ignoresSafeArea()
