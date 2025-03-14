//
//  RomanticCalendarView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-02.
//
import SwiftUI

struct RomanticDropdownView: View {
    var fieldText: String
    @Binding var varToEdit: Int?
    @State private var isExpanded = false
    private var values: [Int]
    
    init(fieldText: String, varToEdit: Binding<Int?>, range: ClosedRange<Int>) {
        self.fieldText = fieldText
        self._varToEdit = varToEdit
        self.values = Array(range)
    }
    
    init(fieldText: String, varToEdit: Binding<Int?>, values: [Int]) {
        self.fieldText = fieldText
        self._varToEdit = varToEdit
        self.values = values
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "123.rectangle")
                    .foregroundColor(varToEdit == nil ? .red.opacity(0.8) : .green.opacity(0.8))
                    .animation(.easeInOut, value: varToEdit)
                
                Menu {
                    ForEach(values, id: \.self) { value in
                        Button(String(value)) {
                            varToEdit = value
                        }
                    }
                } label: {
                    HStack {
                        Text(varToEdit == nil ? fieldText : "\(varToEdit!)")
                            .foregroundColor(varToEdit == nil ? .gray.opacity(0.6) : .black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(8)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.primary.opacity(0.6))
                            .padding(.trailing, 5)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.black.opacity(0.3), lineWidth: 1)
                    )
                }
            }
        }
    }
}
