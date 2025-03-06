//
//  RomanticButton.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-04.
//

import SwiftUI

//// For synchronous actions:
//RomanticButton(
//    isLoading: $isLoading,
//    text: "Submit",
//    action: {
//        await Task.yield() // Convert to async
//        return synchronousFunction()
//    }
//)


struct RomanticButton: View {
    @Binding var isLoading: Bool
    var text: String
    
    var systemImage: String?
    var linearGradient: LinearGradient = LinearGradient(
        colors: [
            Color.softPink,
            Color.teal.opacity(0.8)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    var verticalPadding: CGFloat = 5
    var horizontalPadding: CGFloat = 20
    var cornerRadius: CGFloat = 20
    var shadowColor: Color = .pink.opacity(0.15)
    
    @State private var showPopover: Bool = false
    @State var result: ButtonActionResult? = nil
    let action: () async -> ButtonActionResult
    
    var body: some View {
        VStack {
            Button {
                isLoading = true
                
                Task {
                    result = await action()
                    isLoading = false
                    showPopover = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showPopover = false
                }
                
            } label: {
                RomanticLabelView(
                    isLoading: $isLoading,
                    text: text,
                    systemImage: systemImage,
                    linearGradient: linearGradient,
                    verticalPadding: verticalPadding,
                    horizontalPadding: horizontalPadding,
                    cornerRadius: cornerRadius,
                    shadowColor: shadowColor
                )

            }
        }
        .popover(isPresented: $showPopover, attachmentAnchor: .point(.bottom), arrowEdge: .top) {
            RomanticResultView(result: $result)
                .presentationCompactAdaptation(.popover)
                .frame(maxHeight: .infinity, alignment: .center)
        }
    }
}
