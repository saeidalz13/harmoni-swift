//
//  PartnerProfileView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-27.
//
import SwiftUI

struct PartnerProfileView: View {
    var user: LocalUser
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    @State var copied = false
    @State var isLoading = false
    @State var isLoadingRefresh = false
    
    init(user: LocalUser) {
        self.user = user
    }
    
    var body: some View {
        RomanticContainer {
            VStack {
                if user.partnerId != nil {
                    Button {
                        UIPasteboard.general.string = user.partnerId
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
                    Text(user.partnerEmail!)
                    Divider()
                    
                    SmallTextLabel(text: "First name 🪪")
                    Text(user.partnerFirstName ?? "No first name!")
                    Divider()

                    SmallTextLabel(text: "Last name 🪪")
                    Text(user.partnerLastName ?? "No last name!")
                    
                   
                    Button {
                        isLoadingRefresh = true
                        Task {
                            do {
                                try await localUserViewModel.getPartner()
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
                            systemImage: "arrow.trianglehead.2.clockwise",
                            text: "Refresh",
                            color: Color.gray
                        )
                        
                    }
//                    CopyItemHStackView(varToCopy: user.partnerId!, text: "Copy ID")
                } else {
                    Text("Refresh to Retrieve Data")
                }
            }
        }
    }
    
}
