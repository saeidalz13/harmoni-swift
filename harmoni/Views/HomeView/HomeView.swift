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
    
    @Query private var users: [LocalUser]
    
    @State private var isEditingUserInfo = false
    
    var body: some View {
        VStack {
            // Section of user and their partner and family title
            HStack{
                if !users.isEmpty {
                    userProfileView(user: users.first, isPartner: false)
                    
                    VStack {
                        CandleView(text: users.first!.familyTitle ?? "No Family Yet")
                    }
                    .padding()
                    .padding(.top, 15)
                    
                    userProfileView(user: users.first, isPartner: true)
                    
                    // Only in test content preview
                } else {
                    Text("No Users")
                    Spacer()
                    Text("No Family/User")
                    Spacer()
                    Text("No Users")
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
        .onAppear {
            seedTestDataIfNeeded()
        }
    }
    
    func userProfileView(user: LocalUser?, isPartner: Bool) -> some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            if let u = user {
                if !isPartner {
                    Text(u.firstName ?? "Click To Set Name")
                        .font(.caption)
                } else {
                    Text(u.partnerID ?? "No Partner!")
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
            if let u = user {
                EditUserView(user: u) { updatedUser in
                    // TODO: make a backend call to update db
                    
                    modelContext.delete(users.first!)
                    modelContext.insert(updatedUser)
                    
                    try modelContext.save()
                }
            } else {
                Text("Error: No user found!")
            }
        }
    }
    
    /// Seeds test users if none exist
    private func seedTestDataIfNeeded() {
        guard users.isEmpty else { return }
        print("loading seed data")
        
        let testUsers = [
            LocalUser(id: "1111", email: "user1@example.com", familyTitle: "The Smiths"),
            LocalUser(id: "2222", email: "partner@example.com", familyTitle: "The Smiths")
        ]
        
        for user in testUsers {
            modelContext.insert(user)
        }
        
        try? modelContext.save()
    }
}
