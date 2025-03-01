//
//  UpkeepView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-28.
//

import SwiftUI


struct UpkeepView: View {
    @State var upkeepVars: [String] = []
    
    var body: some View {
        ScrollView {
            if upkeepVars.isEmpty {
                Text("Upkeep")
            } else {
                RomanticContainer {
                    VStack {
                        ForEach(upkeepVars, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
        .task {
            do {
                upkeepVars = try await fetchUpkeep()
            } catch {
                //
            }
        }
        .animation(.easeInOut, value: upkeepVars)
    }
    
    func fetchUpkeep() async throws -> [String] {
        return ["groceries", "others", "A"]
    }
}
