//
//  harmoniApp.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-25.
//

import SwiftUI
import SwiftData
import GoogleSignIn


@main
struct harmoniApp: App {
    @State var authViewModel: AuthViewModel
    @State var localUser: LocalUser?
    
    var container: ModelContainer

    init() {
        do {
            let storeURL = URL.documentsDirectory.appending(path: "database.sqlite")
            print("Database path:", storeURL.path)
            let schema = Schema(
                [
                    LocalUser.self
                ]
            )
            let configurations = ModelConfiguration(url: storeURL)
            container = try ModelContainer(for: schema, configurations: configurations)
        } catch {
            fatalError("Failed to configure SwiftData container.")
        }
        
        self._authViewModel = State(initialValue: .init(
                modelContext: container.mainContext)
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authViewModel)
                .modelContainer(container)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        if let error {
                            print("Could not restore google user sign in: \(error.localizedDescription)")
                            return
                        }
                        
                        let accessToken = KeychainManager.shared.retrieveFromKeychain(key: KeychainTokenKey.accessToken.rawValue)
                        if accessToken == nil {
                            print("no access token in keychain")
                            GIDSignIn.sharedInstance.signOut()
                            return
                        }
                        
                        let refreshToken = KeychainManager.shared.retrieveFromKeychain(key: KeychainTokenKey.refreshToken.rawValue)
                        if refreshToken == nil {
                            print("no refresh token in keychain")
                            GIDSignIn.sharedInstance.signOut()
                            return
                        }
                        
                        
                        guard let user = user else { return }
                        guard let profile = user.profile else { return }
                        let email = profile.email
                        
                        let fd = FetchDescriptor<LocalUser>(
                            predicate: #Predicate { $0.email == email }
                        )
                        
                        do {
                            if let localUser = try container.mainContext.fetch(fd).first {
                                print(localUser.firstName ?? "no first name")
                                self.authViewModel.localUser = localUser
                            } else {
                                print("no user on appear")
//                                guard let idToken = user.idToken else {
//                                    print("No id token was found in Google payload")
//                                    return
//                                }
//                                try await authViewModel.authenticateBackend(idToken: idToken.tokenString)
                            }
                            
                        } catch {
                            print("error in finding user from db: \(error)")
                            GIDSignIn.sharedInstance.signOut()
                        }

                    }
                }
        }
    }
}
