//
//  HomeView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-30.
//
// This has View protocol (interface) in it.
import SwiftUI


enum TabSelection: Int8 {
    case home
    case relationship
    case finance
    case upkeep
    case settings
}


struct MainView: View {
    @State private var selection: Int8 = TabSelection.home.rawValue
    @State private var isChatActive = false
    
    init() {
        let scrollEdgeAppearance = UITabBarAppearance()
        scrollEdgeAppearance.configureWithDefaultBackground()
        scrollEdgeAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        scrollEdgeAppearance.backgroundColor = UIColor.clear
//        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        UITabBar.appearance().standardAppearance = scrollEdgeAppearance
        UITabBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                Group {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                        .tag(TabSelection.home.rawValue)
                    
                    RelationshipView()
                        .tabItem {
                            Label("Relationship", systemImage: "heart.fill")
                        }
                        .tag(TabSelection.relationship.rawValue)
                    
                    FinanceView()
                        .tabItem {
                            Label("Finance", systemImage: "dollarsign.ring")
                        }
                        .tag(TabSelection.finance.rawValue)
                    
                    UpkeepView()
                        .tabItem {
                            Label("Upkeep", systemImage: "basket.fill")
                        }
                        .tag(TabSelection.upkeep.rawValue)
                    
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "slider.horizontal.2.square")
                        }
                        .tag(TabSelection.settings.rawValue)
                }
                .background(backgroundView())
                .ignoresSafeArea()
                
            }.tint(Color.maroon)
            
            VStack {
                HStack {
                    Button(action: {
                        isChatActive.toggle()
                    }) {
                        Image(systemName: "message.fill")
                            .foregroundStyle(Color.maroon)
                            .font(.title)
                    }
                    .sheet(isPresented: $isChatActive) {
                        ChatMenuView()
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.trailing, 25)
                .padding(.bottom, 5)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 65)
            .background(.clear)
        }
    }
    
    /// Chooses different colors for different tabs
    private func backgroundView() -> some View {
        let gradientColors: [Color]
        //
        switch selection {
        case TabSelection.home.rawValue:
            gradientColors = [Color.purple.opacity(0.7), Color.purple.opacity(0.2)]
        case TabSelection.relationship.rawValue:
            gradientColors = [Color.pink.opacity(0.9), Color.purple.opacity(0.6)]
        case TabSelection.finance.rawValue:
            gradientColors = [Color.orange.opacity(0.8), Color.yellow.opacity(0.5)]
        case TabSelection.upkeep.rawValue:
            gradientColors = [Color.green.opacity(0.8), Color.teal.opacity(0.6)]
        case TabSelection.settings.rawValue:
            gradientColors = [Color.blue.opacity(0.8), Color.teal.opacity(0.6)]
        default:
            gradientColors = [Color.white, Color.gray]
        }

        return LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom)
            .overlay(heartOverlay())
    }
    
    /// Creates a romantic heart overlay effect
    private func heartOverlay() -> some View {
        ZStack {
            ForEach(0..<10, id: \.self) { _ in
                Image(systemName: "heart.fill")
                    .foregroundColor(.white.opacity(0.2))
                    .font(.system(size: CGFloat.random(in: 50...150)))
                    .position(
                        x: CGFloat.random(in: 50...UIScreen.main.bounds.width - 50),
                        y: CGFloat.random(in: 100...UIScreen.main.bounds.height - 100)
                    )
            }
        }
    }
}
