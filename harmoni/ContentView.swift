//
//  ContentView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-25.
//
import SwiftUI

struct ContentView: View {
    @State var isAuth = false
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    
    var body: some View {
        ZStack {
            if localUserViewModel.localUser == nil {
                AuthView()
            } else if localUserViewModel.localUser?.bond == nil {
                BrandNewUserHomeView()
            } else {
                MainView()
            }
        }
    }
}

