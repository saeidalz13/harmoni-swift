//
//  UserProfileView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-27.
//
import SwiftUI

struct UserProfileView: View {
    var user: User?
    var isPartner: Bool
    @State var showPopover: Bool = false
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    
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
        .cornerRadius(30)
        .shadow(radius: 20)
        .onTapGesture {
            showPopover = true
        }
        .popover(isPresented: $showPopover) {
            if let lu = localUserViewModel.localUser {
                Group {
                    if !isPartner {
                        UpdateUserView(user: lu)
                            .padding()
                            .frame(maxHeight: 300, alignment: .center)
                    } else {
                        PartnerProfileView(user: lu)
                            .padding()
                            .frame(alignment: .center)
                    }
                }
                .presentationCompactAdaptation(.popover)
            }
        }
    }
}
