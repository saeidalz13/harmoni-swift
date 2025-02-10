//
//  EditUserView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-09.
//

import SwiftUI

struct EditUserView: View {
    @Environment(\.presentationMode) var presentationMode
    var user: LocalUser
    var onSave: (LocalUser) throws -> Void

    // Store only the email separately
    @State private var editedEmail: String
    @State private var editedFirstName: String
    @State private var editedLastName: String

    init(user: LocalUser, onSave: @escaping (LocalUser) throws -> Void) {
        self.user = user
        self._editedEmail = State(initialValue: user.email)
        self._editedFirstName = State(initialValue: user.firstName ?? "")
        self._editedLastName = State(initialValue: user.lastName ?? "")
        self.onSave = onSave
    }

    var body: some View {
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
                        do {
                            user.email = editedEmail
                            user.firstName = editedFirstName
                            user.lastName = editedLastName
                            
                            try onSave(user)
                            presentationMode.wrappedValue.dismiss()
                        } catch {
                            print("Error saving user: \(error)")
                        }
                    }
                }
            }
        }
    }
}
