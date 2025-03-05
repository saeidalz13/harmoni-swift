//
//  NewUserSuggestionsView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-28.
//

import SwiftUI


struct NewUserSuggestionsView: View {
    @State var copied: Bool = false
    @State var isLoading: Bool = false
    @State var isLoadingRefresh: Bool = false
    @State var err: String?
    @Environment(UserViewModel.self) private var userVM
    
    var bond: Bond?
    
    var body: some View {
        if let b = bond {
            RomanticContainer {
                Text("💌 Share Bond ID")
                    .font(.headline)
                    .foregroundStyle(.pink)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .scaleEffect(1.05)
                    .animation(.easeInOut(duration: 0.4), value: b.id)
                
                Text("So they can complete this bond with you 💫")
                    .font(.caption)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .opacity(0.8)
                
                Button {
                    UIPasteboard.general.string = b.id
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
            }
            .padding(.horizontal, 20)
        }
        
        RomanticContainer {
            
            Text("If your partner has joined, refresh to retrieve their info")
                .font(.caption)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .opacity(0.8)
            
            Button {
                isLoadingRefresh = true
                Task {
                    do {
                        try await userVM.fetchPartner()
                    } catch GeneralError.optionalFieldUnavailable {
                        err = "You should create/join a bond first!"
                    } catch {
                        err = "Guess this is an oopsie for us :( Something went wrong!"
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
            
            
        }
        .padding(.horizontal, 20)
    }
}


//

