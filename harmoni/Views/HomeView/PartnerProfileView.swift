//
//  PartnerProfileView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-27.
//
import SwiftUI

struct PartnerProfileView: View {
    var user: LocalUser
    @State var serverErr: String?
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    
    init(user: LocalUser) {
        self.user = user
    }
    
    var body: some View {
        VStack {
            if user.partnerId != nil {
                Text(user.partnerEmail!)
                Text(user.partnerFirstName ?? "No first name!")
                Text(user.partnerLastName ?? "No last name!")
                CopyItemHStackView(varToCopy: user.partnerId!, text: "Copy ID")
                
            } else {
                Button {
                    Task {
                        do {
                            try await localUserViewModel.getPartner()
                        } catch GeneralError.optionalFieldUnavailable {
                            serverErr = "You should create/join a bond first!"
                        } catch {
                            print(error)
                            serverErr = "failed to refresh"
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            serverErr = nil
                        }
                    }
                } label: {
                    Label("Refresh", systemImage: "arrow.trianglehead.2.clockwise")
                }
                
                if let se = serverErr {
                    Text(se)
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
        }
        
    }
    
}
