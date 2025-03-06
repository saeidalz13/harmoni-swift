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
                    HStack {
                        Text(copied ? "Copied!" : "Copy ID")
                            .padding(.horizontal, 2)
                            .font(.avenirCaption)
                            .foregroundStyle(Color.black)
                        
                        if copied {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .transition(.opacity)
                        } else {
                            Image(systemName: "doc.on.doc")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(8)
                    .background(Color.creamyLavender.opacity(0.2))
                    .clipShape(Capsule())
                }
                
            }
            .padding(.horizontal, 20)
            
            RefreshPartnerView()
        }
    }
}

