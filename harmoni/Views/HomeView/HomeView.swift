//
//  HomeView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-01.
//
import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    @Environment(AuthViewModel.self) private var authViewModel
    
    @State var homeViewModel = HomeViewModel()
    
    @State private var user: UserInfo?
    @State private var isEditingUserInfo = false
    @State private var isLoading = false
    @State private var isLoadingRefresh = false
    @State private var copied = false
    @State private var serverErr: String?
    

    var body: some View {
        ScrollView {
            
            if !authViewModel.isHarmoniFirstTimeUser {
                HStack{
                    UserProfileView(user: user?.user, isPartner: false)
                    
                    VStack {
                        CandleView(text: user?.bond?.bondTitle ?? "No Bond Yet")
                    }
                    .padding()
                    .padding(.top, 15)
                    
                    UserProfileView(user: user?.partner, isPartner: true)
                }
                
                if user?.partner?.id == nil {
                    NewUserSuggestionsView(bondId: "")
                    
                } else {
                    
                    // View when user has both Bond and Partner
                    RelationshipSummaryView()
                }
                
            } else {
                FirstTimeUserHomeView()
            }

            Spacer(minLength: 120)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            guard let email = authViewModel.email else { return }
            do {
                user = try await homeViewModel.fetchUser(email: email)
            } catch {
                print(error)
            }
        }
        .animation(.easeInOut, value: user != nil)
    }
    
}


/// Seeds test users if none exist
//    private func seedTestDataIfNeeded() {
//        guard let lu = authViewModel.localUser else { return }
//        print("loading seed data")
//
//        let testUsers = [
//            LocalUser(id: "1111", email: "user1@example.com", bondTitle: "The Smiths"),
//            LocalUser(id: "2222", email: "partner@example.com", familyTitle: "The Smiths")
//        ]
//
//        for user in testUsers {
//            modelContext.insert(user)
//        }
//
//        try? modelContext.save()
//    }
//

