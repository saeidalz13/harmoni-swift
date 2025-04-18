//
//  RomanticHeaderInContainerView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-13.
//

import SwiftUI

struct RomanticHeaderInContainerView: View {
    var header: String
    
    var body: some View {
        VStack {
            Text(header)
                .font(.avenirHeadline)
        }
        .padding(.vertical, 15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.creamyLavender.opacity(0.2))
        .clipShape(
            .rect(
                topLeadingRadius: 20,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 20
            )
        )
    }
}
