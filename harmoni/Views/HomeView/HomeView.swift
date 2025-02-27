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

struct UserProfileView: View {
    var user: LocalUser?
    var isPartner: Bool
    @State var showEditProfile: Bool = false
    @Environment(LocalUserViewModel.self) private var authViewModel
    
    var body: some View {
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
                    Text(
                        u.partnerId != nil ? (u.partnerFirstName?.isEmpty == false ? u.partnerFirstName! : u.partnerEmail ?? "No Partner!") : "No Partner!"
                    )
                    
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
                showEditProfile = true
            }
        }
        .popover(isPresented: $showEditProfile) {
            if let lu = authViewModel.localUser {
                UpdateUserView(user: lu)
                    .presentationCompactAdaptation(.popover)
                    .padding()
                    .frame(maxHeight: 300, alignment: .center)
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
//func userProfileView(user: LocalUser?, isPartner: Bool) -> some View {
//    VStack {
//        Image(systemName: "person.crop.circle")
//            .resizable()
//            .scaledToFill()
//            .frame(width: 50, height: 50)
//            .padding(.bottom, 5)
//            .clipShape(Circle())
//
//        if let u = user {
//            if !isPartner {
//                Text(u.firstName?.capitalized ?? "Click To Set Name")
//                    .font(.caption)
//            } else {
//                Text(u.partnerId ?? "No Partner!")
//                    .font(.caption)
//            }
//        }
//
//    }
//    .frame(width: 80, height: 100)
//    .padding()
//    .background(Color.white.opacity(0.8))
//    .cornerRadius(10)
//    .shadow(radius: 20)
//    .onTapGesture {
//        if !isPartner {
//            isEditingUserInfo = true
//        }
//    }
//    .sheet(isPresented: $isEditingUserInfo) {
//        if let lu = authViewModel.localUser {
//            UpdateUserView(user: lu)
//        }
//    }
//}
