//
//  CopyItemHStackView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-27.
//
import SwiftUI

struct CopyItemHStackView: View {
    @State var copied = false
    var varToCopy: String
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.caption)
            Button {
                UIPasteboard.general.string = varToCopy
                copied = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    copied = false
                }
            } label: {
                Image(systemName: copied ? "checkmark.circle.fill" : "doc.on.doc")
                    .foregroundColor(copied ? .green : .blue)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
