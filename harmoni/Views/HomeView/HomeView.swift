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
    @Environment(\.modelContext) private var modelContext
    
    @State private var isEditingUserInfo = false
    @State var isLoading = false
    @State var isLoadingRefresh = false
    @State var copied = false
    @State var serverErr: String?

    var body: some View {
        ScrollView {
            if let lu = localUserViewModel.localUser {
                if let bond = lu.bond {
                    
                    HStack{
                        if let lu = localUserViewModel.localUser {
                            UserProfileView(user: lu, isPartner: false)
                            
                            VStack {
                                CandleView(text: lu.bond?.title ?? "No Bond Yet")
                            }
                            .padding()
                            .padding(.top, 15)
                            
                            UserProfileView(user: lu, isPartner: true)
                            
                        }
                    }
                    
                    if lu.partnerId == nil {
                        NewUserSuggestionsView(bondId: bond.id)
                    } else {
                        // View when user has both Bond and Partner
                        
                        RelationshipSummaryView()
                    }
                    
                } else {
                    FirstTimeUserHomeView()
                }
                
            }
            Spacer(minLength: 120)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .task {
            do {
                
            } catch {
                
            }
        }
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

