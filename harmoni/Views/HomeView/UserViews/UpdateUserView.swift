//
//  EditUserView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-09.
//

import SwiftUI

struct UpdateUserView: View {
//    @Environment(\.presentationMode) var presentationMode
    @Environment(LocalUserViewModel.self) private var localUserViewModel
    var user: User?
    
    @State private var editedEmail: String
    @State private var editedFirstName: String
    @State private var editedLastName: String
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isLoading = false
    
    init(user: User?) {
        self.user = user
        if let u = user {
            self._editedEmail = State(initialValue: u.email)
            self._editedFirstName = State(initialValue: u.firstName ?? "")
            self._editedLastName = State(initialValue: u.lastName ?? "")
        }
        else {
            self._editedEmail = State(initialValue: "=")
            self._editedFirstName = State(initialValue:  "")
            self._editedLastName = State(initialValue: "")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("Personal Info") {
                        TextField("Email", text: $editedEmail)
                        TextField("First Name", text: $editedFirstName)
                        TextField("Last Name", text: $editedLastName)
                    }
                }
                
                Button {
                    Task {
                        await updateUser()
                    }
                } label: {
                    RomanticLabelView(isLoading: $isLoading,  text: "Update", systemImage: "list.bullet.clipboard.fill")
                }
                .disabled(isLoading)
            }
        }
    }
    
    /// Updates user information with a loading indicator
    private func updateUser() async {
        isLoading = true
        do {
//            try await localUserViewModel.updateUser(
//                email: editedEmail.lowercased(),
//                firstName: editedFirstName.lowercased(),
//                lastName: editedLastName.lowercased()
//            )
            alertTitle = "Success"
            alertMessage = "Personal info updated successfully!"
        } catch {
            alertTitle = "Error"
            alertMessage = "Failed to update personal info!"
            print("Error update user: \(error.localizedDescription)")
        }
        
        isLoading = false
        showAlert = true
    }
}


//
//NavigationView {
//    Form {
//        TextField("Email", text: $editedEmail)
//        TextField("First Name", text: $editedFirstName)
//        TextField("Last Name", text: $editedLastName)
//    }
//    .navigationTitle("Edit Profile")
//    .toolbar {
//        ToolbarItem(placement: .cancellationAction) {
//            Button("Cancel") {
//                presentationMode.wrappedValue.dismiss()
//            }
//        }
//        ToolbarItem(placement: .confirmationAction) {
//            Button("Save") {
//                Task {
//                    await updateUser()
//                }
//            }
//            .disabled(isLoading)
//        }
//    }
//}
