//
//  SettingsView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-14.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            HStack {
                Logout()
            }
            .padding(.top, 100)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

    }
}
