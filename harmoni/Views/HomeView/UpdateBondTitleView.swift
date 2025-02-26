//
//  UpdateBondTitleView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-17.
//
import SwiftUI

struct UpdateBondTitleView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(LocalUserViewModel.self) private var authViewModel
    
    @State private var editedBondTitle: String
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isLoading = false
    
    init(bondTitle: String?) {
        self._editedBondTitle = State(initialValue: bondTitle ?? "")
    }
    
    var body: some View {
        
        ZStack {
            NavigationStack {
                Form {
                    TextField("Bond Title", text: $editedBondTitle)
                }
                .navigationTitle("Edit Bond Title")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            Task {
                                await updateBondTitle()
                            }
                        }
                        .disabled(isLoading)
                    }
                }

            }
            
        }
    }
    
    private func updateBondTitle() async {
//        if editedBondTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//            showAlert = true
//            alertMessage = "Please enter a bond title!"
//            alertTitle = "Oops!"
//            return
//        }
//        
//        isLoading = true
//        do {
//            try await authViewModel.updateBondTitle(bondTitle: editedBondTitle)
//            alertTitle = "Success"
//            alertMessage = "Bond title updated successfully!"
//        } catch {
//            alertTitle = "Error"
//            alertMessage = "Failed to update bond title!"
//            print(error)
//        }
//        
//        isLoading = false
//        showAlert = true
    }
}
