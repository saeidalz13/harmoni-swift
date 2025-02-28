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
    
    var body: some View {
        VStack {
            // Section of user and their partner and bond title
            HStack{
                if let lu = localUserViewModel.localUser {
                    UserProfileView(user: lu, isPartner: false)
                    
                    VStack {
                        CandleView(text: lu.bondTitle ?? "No Bond Yet")
                    }
                    .padding()
                    .padding(.top, 15)
                    
                    UserProfileView(user: lu, isPartner: true)
                    
                }
            }
            .padding()
            .padding(.top, 50)
            
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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

