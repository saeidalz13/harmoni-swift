//
//  RefreshPartnerView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-05.
//

import SwiftUI

struct RefreshPartnerView: View {
    @Environment(UserViewModel.self) private var userVM
    @State private var isLoadingRefresh: Bool = false
    
    var body: some View {
        RomanticContainer {
            
            Text("If your partner has joined, refresh to retrieve their info")
                .font(.caption)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .opacity(0.8)
            
            RomanticButton(
                isLoading: $isLoadingRefresh,
                text: "Refresh",
                systemImage:  "arrow.trianglehead.2.clockwise",
                action: refresh
            )
            
        }
        .padding(.horizontal)
    }
    
    private func refresh() async -> ButtonActionResult {
        do {
            try await userVM.fetchPartner()
            return .fulfilled("Successfully refreshed")
            
        } catch GeneralError.optionalFieldUnavailable {
            return .notFulfilled("Your person is in your heart but not in our database, yet!")

        } catch {
            return .serverError
        }
    }
}
