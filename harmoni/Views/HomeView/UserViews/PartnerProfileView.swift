//
//  PartnerProfileView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-27.
//
import SwiftUI

struct PartnerProfileView: View {
    var user: User?
    @State var copied = false
    @State var isLoading = false
    @State var isLoadingRefresh = false
    @Environment(UserViewModel.self) private var userVM
    
    var body: some View {
        RomanticContainer(width: 250) {
            VStack {
                if let u = user  {
                    Button {
                        UIPasteboard.general.string = u.id
                        copied = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            copied = false
                        }
                    } label: {
                        RomanticLabelView(isLoading: $isLoading, text: "Copy ID 🔗")
                        if copied {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .transition(.opacity)
                        }
                    }
                    .padding(.bottom, 5)
 
                    SmallTextLabel(text: "email 📥")
                    Text(u.email)
                    Divider()
                    
                    SmallTextLabel(text: "First name 🪪")
                    Text(u.firstName ?? "No first name!")
                    Divider()

                    SmallTextLabel(text: "Last name 🪪")
                    Text(u.lastName ?? "No last name!")
                    
                   
                    Button {
                        isLoadingRefresh = true
                        Task {
                            do {
                                try await userVM.fetchPartner()
                            } catch GeneralError.optionalFieldUnavailable {
//                                serverErr = "You should create/join a bond first!"
                            } catch {
                                print(error)
                            }
                            
                            isLoadingRefresh = false
                        }
                    } label: {
                        RomanticLabelView(
                            isLoading: $isLoadingRefresh,
                            text: "Refresh",
                            systemImage: "arrow.trianglehead.2.clockwise"
                        )
                        
                    }

                } else {
                    Text("Refresh to Retrieve Data")
                }
            }
        }
    }
    
}
