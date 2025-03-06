//
//  RomanticResultView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-04.
//
import SwiftUI

struct RomanticResultView: View {
    @Binding var result: ButtonActionResult?
    @State private var isVisible = false
    
    var body: some View {
        VStack(spacing: 5) {
            
            switch result {
            case .fulfilled:
                Group {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.teal)
                    Text("Success!")
                        .font(.avenirBold)
                    
                }
                .opacity(isVisible ? 1 : 0)
                .scaleEffect(isVisible ? 1.1 : 0.6)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isVisible = true
                    }
                }
                
                
            case .notFulfilled(let msg):
                Group {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.softPink)

                    Text(result!.title)
                        .font(.avenirBold)

                    Text(msg) // Only use msg here because we know this case has a message
                        .font(.avenirCaption)
                        .multilineTextAlignment(.center)
                }
                .opacity(isVisible ? 1 : 0)
                .scaleEffect(isVisible ? 1 : 0.6)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isVisible = true
                    }
                }

            case .serverError:
                Group {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.softPink)

                    Text(result!.title)
                        .font(.avenirBold)

                    Text(result!.msg) // Use result!.msg because it's hardcoded in the enum
                        .font(.avenirCaption)
                        .multilineTextAlignment(.center)
                }
                .opacity(isVisible ? 1 : 0)
                .scaleEffect(isVisible ? 1 : 0.6)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isVisible = true
                    }
                }

                // Loading state
            case .none:
                OrbitingHeartsView(mainHeartSize: 20, orbitingHeartSize: 15, orbitRadius: 10)
                    .previewLayout(.sizeThatFits)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColorForResult(result))
    }
    
    func backgroundColorForResult(_ result: ButtonActionResult?) -> Color {
        guard let result = result else {
            return .creamyLavender.opacity(0.15)
        }
        
        switch result {
        case .fulfilled: return .teal.opacity(0.15)
        case .serverError, .notFulfilled: return .softPink.opacity(0.15)
        }
    }
}
