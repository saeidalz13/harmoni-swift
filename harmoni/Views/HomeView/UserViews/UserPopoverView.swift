//
//  EditUserView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-02-09.
//

import SwiftUI

struct UserPopoverView: View {
    var user: User?
    @Environment(UserViewModel.self) private var userVM
    
    @State private var editedEmail: String
    @State private var editedFirstName: String
    @State private var editedLastName: String
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
        RomanticPopoverContainer {
                Text("Update Info")
                    .font(.avenirBold)
            
                RomanticTextField(
                    fieldText: "Email",
                    varToEdit: $editedEmail
                )
                .padding(.bottom, 5)
                .frame(width: 250, alignment: .leading)
                
                RomanticTextField(
                    fieldText: "First Name",
                    varToEdit: $editedFirstName
                )
                .padding(.bottom, 5)
                .frame(width: 250)
                

                RomanticTextField(
                    fieldText: "Last Name",
                    varToEdit: $editedLastName
                )
                .padding(.bottom, 10)
                .frame(width: 250)
            
                
            RomanticButton(isLoading: $isLoading, text: "Update", action: updateUser)
        }

    }
    
    func updateUser() async -> ButtonActionResult {
        do {
            try await userVM.updateUser(email: editedEmail, firstName: editedFirstName, lastName: editedLastName)
            return .fulfilled("Success!")
        } catch {
            return .serverError
        }
    }
}

