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
    @State var localUserViewModel: LocalUserViewModel
    var container: ModelContainer
    
    init() {
        do {
            let storeURL = URL.documentsDirectory.appending(path: "database.sqlite")
//            print("Database path:", storeURL.path)
            let schema = Schema(
                [
                    LocalUser.self
                ]
            )
            let configurations = ModelConfiguration(url: storeURL)
            container = try ModelContainer(for: schema, configurations: configurations)
        } catch {
            print(error)
            fatalError("Failed to configure SwiftData container.")
        }
        
        self._localUserViewModel = State(
            initialValue: .init(
                modelContext: container.mainContext
            )
        )
        self._authViewModel = State(initialValue: .init())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(localUserViewModel)
                .environment(authViewModel)
                .modelContainer(container)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        if let error {
                            print("Could not restore google user sign in: \(error.localizedDescription)")
                            authViewModel.isLoading = false
                            return
                        }
          
//                        KeychainManager.shared.removeTokensFromKeychain()
//                        KeychainManager.shared.removeTokenByKey(key: .isHarmoniFirstTimeUser)
//                        GIDSignIn.sharedInstance.signOut()
//                        return
                        
                        let accessToken = KeychainManager.shared.retrieveFromKeychain(key: KeychainKey.accessToken)
                        if accessToken == nil {
                            print("no access token in keychain")
                            GIDSignIn.sharedInstance.signOut()
                            authViewModel.isLoading = false
                            return
                        }
                        let refreshToken = KeychainManager.shared.retrieveFromKeychain(key: KeychainKey.refreshToken)
                        if refreshToken == nil {
                            print("no refresh token in keychain")
                            GIDSignIn.sharedInstance.signOut()
                            authViewModel.isLoading = false
                            return
                        }
                        
                        let isHarmoniFirstTimeUserStr = KeychainManager.shared.retrieveFromKeychain(
                            key: KeychainKey.isHarmoniFirstTimeUser
                        )
                        authViewModel.isHarmoniFirstTimeUser = isHarmoniFirstTimeUserStr == nil
                        
                        guard let user = user else { return }
                        guard let profile = user.profile else { return }
                        authViewModel.email = profile.email
                        authViewModel.isAuth = true
                        authViewModel.isLoading = false
                    }
                }
        }
    }
}
