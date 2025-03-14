//
//  harmoniApp.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-25.
//

import SwiftUI
import GoogleSignIn


@main
struct harmoniApp: App {
    @State var authVM: AuthViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authVM)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    let loadingStartTime = Date()
                    
//                    KeychainManager.shared.removeTokenByKey(key: .isHarmoniFirstTimeUser)
//                    authVM.signOutClient()
//                    GIDSignIn.sharedInstance.signOut()
//                    return
                    
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        if let error {
                            print("Could not restore google user sign in: \(error.localizedDescription)")
                            authVM.isLoading = false
                            return
                        }
                        
                        if !authVM.authTokensExistInKeychain() {
                            GIDSignIn.sharedInstance.signOut()
                            return
                        }
                        
                        guard let user = user else { return }
                        guard let profile = user.profile else { return }
                        
                        authVM.signInUser(loadingStartTime: loadingStartTime, email: profile.email)
                        
                    }
                }
        }
    }
}


//        do {
//            let storeURL = URL.documentsDirectory.appending(path: "database.sqlite")
//            //            print("Database path:", storeURL.path)
//            let schema = Schema(
//                [
//                    LocalUser.self
//                ]
//            )
//            let configurations = ModelConfiguration(url: storeURL)
//            container = try ModelContainer(for: schema, configurations: configurations)
//        } catch {
//            print(error)
//            fatalError("Failed to configure SwiftData container.")
//        }
        
