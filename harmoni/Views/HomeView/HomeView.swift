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
    @Environment(\.modelContext) private var modelContext
    
    @State var homeViewModel = HomeViewModel()
    
    @State private var user: User?
    @State private var isEditingUserInfo = false
    @State private var isLoading = false
    @State private var isLoadingRefresh = false
    @State private var copied = false
    @State private var serverErr: String?
    
    init() {
        self._user = .init(initialValue: User.empty())
    }

    var body: some View {
        ScrollView {
            
            if !authViewModel.isHarmoniFirstTimeUser {
                HStack{
                    UserProfileView(user: user, isPartner: false)
                    
                    VStack {
                        CandleView(text: user?.bondTitle ?? "No Bond Yet")
                    }
                    .padding()
                    .padding(.top, 15)
                    
                    UserProfileView(user: user, isPartner: true)
                }
                
                if user?.partnerId == nil {
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

