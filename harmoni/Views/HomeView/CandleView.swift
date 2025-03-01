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
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    
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
            showPopover = true
        }
        .popover(isPresented: $showPopover, attachmentAnchor: .point(.bottom), arrowEdge: .top) {
            BondPopoverView()
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

struct BondPopoverView: View {
    @State var newBondTitle = ""
    @State private var isLoading: Bool = false
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            if let bond = localUserViewModel.localUser!.bond {
                Text("Title: \(bond.title)")
                    .font(.headline)

                Divider()
            
                TextField("New Title", text: $newBondTitle)
                    .padding(5)
                    .background(Color(.systemGray.withAlphaComponent(0.1)))
                    .cornerRadius(10)
                
                Button {
                    Task {
                        isLoading = true
                        
                        do {
                            try await localUserViewModel.updateBond(bondTitle: newBondTitle)
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                        isLoading = false
                    }
                } label: {
                    RomanticLabelView(isLoading: $isLoading, systemImage: "list.bullet.clipboard.fill", text: "Update")
                }
                
            } else {
                Text("Build a bond first please!")
            }
        }
        
    }
}
