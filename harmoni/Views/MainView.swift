//
//  HomeView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-30.
//
// This has View protocol (interface) in it.
import SwiftUI


struct MainView: View {
    @State private var selection: Int8 = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Tab("Home", systemImage: "house.fill", value: 0) {
                HomeView()
            }
            
            Tab("Relationship", systemImage: "heart.fill", value: 0) {
                Label("Lightning", systemImage: "bolt.fill")
            }

            
            Tab("Finance", systemImage: "dollarsign.ring", value: 0) {
                Label("Lightning", systemImage: "bolt.fill")
            }
            
            Tab("Upkeep", systemImage: "basket.fill", value: 0) {
                Label("Lightning", systemImage: "bolt.fill")
            }
            
        }
    }
}
