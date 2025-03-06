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
    @Environment(AuthViewModel.self) private var authViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .padding(.bottom, 5)
                .clipShape(Circle())
            
            if let u = user {
                Text(u.firstName?.capitalized ?? "Click To Set Name")
                    .font(.caption)
            }
            
        }
        .frame(width: 80, height: 100)
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(40)
        .shadow(radius: 20)
        .onTapGesture {
            showPopover = true
        }
        .popover(isPresented: $showPopover) {
            Group {
                if !isPartner {
                    UpdateUserView(user: user)
                        .padding()
                        .frame(maxHeight: 300, alignment: .center)
                } else {
                    PartnerProfileView(user: user)
                        .padding()
                        .frame(alignment: .center)
                }
            }
            .presentationCompactAdaptation(.popover)
            
        }
    }
}
