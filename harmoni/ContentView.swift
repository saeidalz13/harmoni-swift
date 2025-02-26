//
//  ContentView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-25.
//
import SwiftUI

struct ContentView: View {
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    
    var body: some View {
        ZStack {
            if localUserViewModel.localUser != nil {
                MainView()
                    .environment(localUserViewModel)
            } else {
                AuthView()
                    .environment(localUserViewModel)
            }
        }
    }
}

