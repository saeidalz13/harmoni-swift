//
//  HomeView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-01.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.05, green: 0.05, blue: 0.2),  // Dark navy blue
                    Color(red: 0.5, green: 0.3, blue: 0.1),   // Warm brown
                    Color(red: 0.72, green: 0.52, blue: 0.04) // Goldenrod
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
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
