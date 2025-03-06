//
//  RomanticPopoverContainer.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-05.
//

import SwiftUI

struct RomanticPopoverContainer<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(HeartedBackgroundView(selection: .popover))
    }
}
