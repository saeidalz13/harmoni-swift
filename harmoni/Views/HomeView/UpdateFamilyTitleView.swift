//
//  UpdateFamilyTitleView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-17.
//
import SwiftUI

struct UpdateFamilyTitleView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(AuthViewModel.self) private var authViewModel
    
    @State private var editedFamilyTitle: String
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isLoading = false
    
    init(familyTitle: String?) {
        self._editedFamilyTitle = State(initialValue: familyTitle ?? "")
    }
    
    var body: some View {
        
        ZStack {
            NavigationStack {
                Form {
                    TextField("Family Title", text: $editedFamilyTitle)
                }
                .navigationTitle("Edit Family Title")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            Task {
                                await updateFamilyTitle()
                            }
                        }
                        .disabled(isLoading)
                    }
                }

            }
            
        }
    }
    
    private func updateFamilyTitle() async {
        if editedFamilyTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlert = true
            alertMessage = "Please enter a family title!"
            alertTitle = "Oops!"
            return
        }
        
        isLoading = true
        do {
            try await authViewModel.updateFamilyTitle(familyTitle: editedFamilyTitle)
            alertTitle = "Success"
            alertMessage = "Family title updated successfully!"
        } catch {
            alertTitle = "Error"
            alertMessage = "Failed to update family title!"
            print(error)
        }
        
        isLoading = false
        showAlert = true
    }
}
