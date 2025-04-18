//
//  RomanticCalendarView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-03-02.
//

import SwiftUI


struct RomanticCalendarView: View {
    var fieldText: String
    @Binding var selectedDate: Date
    @State private var isShowingDatePicker = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(selectedDate < Calendar.current.startOfDay(for: Date()) ? .green.opacity(0.8) : .red.opacity(0.8))
                
                Button(action: {
                    isShowingDatePicker.toggle()
                }) {
                    HStack {
                        Text(selectedDate == Date.distantPast ? fieldText : dateFormatter.string(from: selectedDate))
                            .foregroundColor(selectedDate == Date.distantPast ? .gray : .primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(8)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.primary.opacity(0.6))
                            .padding(.trailing, 5)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.primary.opacity(0.3), lineWidth: 1)
                    )
                }
            }
            
            if isShowingDatePicker {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.primary.opacity(0.3), lineWidth: 1)
                )
                .transition(.scale)
            }
        }
    }
}
