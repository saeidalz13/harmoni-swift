//
//  NewUserSuggestionsView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-28.
//

import SwiftUI


struct NewUserSuggestionsView: View {
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    @State var copied: Bool = false
    @State var isLoading: Bool = false
    @State var isLoadingRefresh: Bool = false
    @State var err: String?
    
    var bondId: String
    
    
    var body: some View {
        RomanticContainer {
            VStack {
                Text("💌 Share Bond ID")
                    .font(.headline)
                    .foregroundStyle(.pink)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .scaleEffect(1.05)
                    .animation(.easeInOut(duration: 0.4), value: bondId)
                
                Text("So they can complete this bond with you 💫")
                    .font(.caption)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .opacity(0.8)
                
                Button {
                    UIPasteboard.general.string = bondId
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
                .padding(.top, 5)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
            .layoutPriority(1)
        }
        
        RomanticContainer {
            VStack {
                Text("If your partner has joined, refresh to retrieve their info")
                    .font(.caption)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .opacity(0.8)
                
                Button {
                    isLoadingRefresh = true
                    Task {
                        do {
                            try await localUserViewModel.getPartner()
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
                        systemImage: "arrow.trianglehead.2.clockwise",
                        text: "Refresh",
                        color: Color.gray
                    )
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
            .layoutPriority(1)
        }
    }
}
