//
//  CandleView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-09.
//

import SwiftUI

struct CandleView: View {
    var text: String
    @State private var showPopover: Bool = false
    @State private var verticalFlameOffset: CGFloat = 40
    @State private var horizontalFlameOffset: CGFloat = 20
    @Environment(UserViewModel.self) private var userVM
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.8))
                .frame(width: 100, height: 120)
                .shadow(color: .orange, radius: 10)
            
            Text(text)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            // Flame
            Ellipse()
                .fill(Color.yellow)
                .frame(width: horizontalFlameOffset, height: verticalFlameOffset)
                .offset(y: -70)
                .onAppear {
                    startFlameAnimation()
                }
        }
        .onTapGesture {
            if userVM.bond != nil {
                showPopover = true
            }
            
        }
        .popover(isPresented: $showPopover, attachmentAnchor: .point(.bottom), arrowEdge: .top) {
            BondPopoverView(bondTitle: userVM.bond!.bondTitle)
                .presentationCompactAdaptation(.popover)
                .padding()
                .frame(minWidth: 300, alignment: .center)
        }
    }
    
    private func startFlameAnimation() {
        withAnimation(
            Animation.easeInOut(duration: 0.5)
                .repeatForever(autoreverses: true)
        ) {
            verticalFlameOffset = 50
            horizontalFlameOffset = 22
        }
    }
}

