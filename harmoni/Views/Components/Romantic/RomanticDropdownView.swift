//
//  RomanticCalendarView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-02.
//
import SwiftUI

struct RomanticDropdownView: View {
    var fieldText: String
    @Binding var selectedAge: Int
    var ageRange: ClosedRange<Int>
    @State private var isExpanded = false
    
    init(fieldText: String, selectedAge: Binding<Int>, range: ClosedRange<Int> = 18...100) {
        self.fieldText = fieldText
        self._selectedAge = selectedAge
        self.ageRange = range
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.primary.opacity(0.6))
                
                Menu {
                    ForEach(ageRange, id: \.self) { age in
                        Button(String(age)) {
                            selectedAge = age
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedAge == 0 ? fieldText : "\(selectedAge)")
                            .foregroundColor(selectedAge == 0 ? .gray : .primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(8)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.primary.opacity(0.6))
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.primary.opacity(0.3), lineWidth: 1)
                    )
                }
            }
        }
    }
}
