//
//  HomeView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-30.
//
// This has View protocol (interface) in it.
import SwiftUI

struct MainView: View {
    @Environment(AuthViewModel.self) private var authVM
    @Environment(UserViewModel.self) private var userVM
    @State private var selection: TabSelection = .home
    
    init() {
        let scrollEdgeAppearance = UITabBarAppearance()
        scrollEdgeAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        scrollEdgeAppearance.backgroundColor = UIColor.clear
        UITabBar.appearance().standardAppearance = scrollEdgeAppearance
        UITabBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
        
        // scrollEdgeAppearance.configureWithDefaultBackground()
        // UITabBar.appearance().unselectedItemTintColor = UIColor.black
    }
    
    var body: some View {
        VStack {
            if authVM.isHarmoniFirstTimeUser {
                OnboardingView()
                
            } else {
                TabView(selection: $selection) {
                    Group {
                        HomeView()
                            .tabItem {
                                Label("Home", systemImage: "house.fill")
                            }
                            .tag(TabSelection.home)
                        
                        RelationshipView()
                            .tabItem {
                                Label("Relationship", systemImage: "heart.fill")
                            }
                            .tag(TabSelection.relationship)
                        
                        FinanceView()
                            .tabItem {
                                Label("Finance", systemImage: "dollarsign.ring")
                            }
                            .tag(TabSelection.finance)
                        
                        UpkeepView()
                            .tabItem {
                                Label("Upkeep", systemImage: "basket.fill")
                            }
                            .tag(TabSelection.upkeep)
                        
                        SettingsView()
                            .tabItem {
                                Label("Settings", systemImage: "slider.horizontal.2.square")
                            }
                            .tag(TabSelection.settings)
                    }
                    .padding(.top, 60)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(HeartedBackgroundView(selection: .tabSelection(selection)))
                    .ignoresSafeArea()
                                        
                }
                .tint(Color.maroon)
                .task {
                    guard let email = authVM.email else { return }
                    do {
                        try await userVM.fetchUserInfo(email: email)
                    } catch GraphQLError.noRefreshTokenUnauthUser {
                        authVM.signOutClient()
                    } catch {
                        print(error)
                    }
                }
                
            }
            
        }
    }
}
//    @State private var isChatActive = false
//            VStack {
//                HStack {
//                    Button(action: {
//                        isChatActive.toggle()
//                    }) {
//                        Image(systemName: "message.fill")
//                            .foregroundStyle(Color.maroon)
//                            .font(.title)
//                    }
//                    .sheet(isPresented: $isChatActive) {
//                        ChatMenuView()
//                    }
//                    
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
//                .padding(.trailing, 25)
//                .padding(.bottom, 5)
//                
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//            .padding(.bottom, 65)
//            .background(.clear)i
