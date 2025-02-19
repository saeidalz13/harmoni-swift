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
    @Environment(\.modelContext) private var modelContext
    
    @State private var isEditingUserInfo = false
    
    var body: some View {
        VStack {
            // Section of user and their partner and family title
            HStack{
                if let lu = authViewModel.localUser {
                    userProfileView(user: lu, isPartner: false)
                    
                    VStack {
                        CandleView(text: lu.familyTitle ?? "No Family Yet")
                    }
                    .padding()
                    .padding(.top, 15)
                    
                    userProfileView(user: lu, isPartner: true)
                    
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
    
    func userProfileView(user: LocalUser?, isPartner: Bool) -> some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .padding(.bottom, 5)
                .clipShape(Circle())
            
            if let u = user {
                if !isPartner {
                    Text(u.firstName?.capitalized ?? "Click To Set Name")
                        .font(.caption)
                } else {
                    Text(u.partnerId ?? "No Partner!")
                        .font(.caption)
                }
            }
            
        }
        .frame(width: 80, height: 100)
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(10)
        .shadow(radius: 20)
        .onTapGesture {
            if !isPartner {
                isEditingUserInfo = true
            }
        }
        .sheet(isPresented: $isEditingUserInfo) {
            if let lu = authViewModel.localUser {
                UpdateUserView(user: lu)
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
//            LocalUser(id: "1111", email: "user1@example.com", familyTitle: "The Smiths"),
//            LocalUser(id: "2222", email: "partner@example.com", familyTitle: "The Smiths")
//        ]
//        
//        for user in testUsers {
//            modelContext.insert(user)
//        }
//        
//        try? modelContext.save()
//    }
