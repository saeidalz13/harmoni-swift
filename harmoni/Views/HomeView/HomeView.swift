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
    @Environment(HomeViewModel.self) private var homeVM
    @Environment(UserViewModel.self) private var userVM
    //    @State var homeVM = HomeViewModel()

    var body: some View {
        ScrollView {
            if !authViewModel.isHarmoniFirstTimeUser {
                HStack{
                    UserProfileView(user: userVM.user, isPartner: false)
                    
                    VStack {
                        CandleView(text: userVM.bond?.bondTitle ?? "No Bond Yet")
                    }
                    .padding()
                    .padding(.top, 15)
                    
                    UserProfileView(user: userVM.partner, isPartner: true)
                        .animation(.easeInOut, value: userVM.partner != nil)
                }
                
                if userVM.partner == nil {
                    NewUserSuggestionsView(bond: userVM.bond)
                } else {
                    RelationshipSummaryView()
                }
                
            } else {
                FirstTimeUserHomeView()
            }

            Spacer(minLength: 120)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
             
        }
        .animation(.easeInOut(duration: 1), value: userVM.user != nil)
    }
    
}


