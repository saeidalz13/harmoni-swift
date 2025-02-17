//
//  EditUserView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-09.
//

import SwiftUI

struct UpdateUserView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(AuthViewModel.self) private var authViewModel
    var user: LocalUser

    @State private var editedEmail: String
    @State private var editedFirstName: String
    @State private var editedLastName: String

    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isLoading = false

    init(user: LocalUser) {
        self.user = user
        self._editedEmail = State(initialValue: user.email)
        self._editedFirstName = State(initialValue: user.firstName ?? "")
        self._editedLastName = State(initialValue: user.lastName ?? "")
    }

    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    TextField("Email", text: $editedEmail)
                    TextField("First Name", text: $editedFirstName)
                    TextField("Last Name", text: $editedLastName)
                }
                .navigationTitle("Edit Profile")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            Task {
                                await updateUser()
                            }
                        }
                        .disabled(isLoading)
                    }
                }
            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }

            // Loading Overlay
            if isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .padding()
                    Text("Updating...")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                .frame(width: 150, height: 150)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
            }
        }
    }

    /// Updates user information with a loading indicator
    private func updateUser() async {
        isLoading = true
        do {
            try await authViewModel.updateUser(
                email: editedEmail,
                firstName: editedFirstName,
                lastName: editedLastName
            )
            alertTitle = "Success"
            alertMessage = "Personal info updated successfully!"
        } catch {
            alertTitle = "Error"
            alertMessage = "Failed to update personal info!"
            print("Error saving user: \(error)")
        }
        isLoading = false
        showAlert = true
    }
}

