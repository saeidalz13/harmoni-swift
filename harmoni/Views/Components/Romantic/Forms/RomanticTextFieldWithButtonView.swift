//
//  RomanticTextField.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-02.
//

import SwiftUI

struct RomanticTextFieldWithButtonView: View {
    var fieldText: String
    var buttonText: String
    @Binding var varToEdit: String
    @Binding var isLoading: Bool
    var systemImage: String?
    var action: () -> Void
    @State var isFieldEmpty = true
    
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "pencil")
                    .foregroundColor(varToEdit.isEmpty ? .red.opacity(0.8) : .green.opacity(0.8))
                    .animation(.easeInOut, value: varToEdit)
                
                TextField(fieldText, text: $varToEdit)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.primary.opacity(0.3), lineWidth: 1)
                    )
            }
            
            Button {
                action()
            } label: {
                RomanticLabelView(isLoading: $isLoading, text: buttonText, systemImage: systemImage)
            }
        }
        .padding(.horizontal)
    }
}
