//
//  HomeView.swift
//  harmoni
//
//  Created by Saeid Alizadeh on 2025-01-30.
//
// This has View protocol (interface) in it.
import SwiftUI


enum TabSelection: Int8 {
    case Home
    case Relationship
    case Finance
    case Upkeep
}


struct MainView: View {
    @State private var selection: Int8 = TabSelection.Home.rawValue
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.clear
        
        let scrollEdgeAppearance = UITabBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()
        UITabBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
        UITabBar.appearance().standardAppearance = scrollEdgeAppearance
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                Group {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                        .tag(TabSelection.Home.rawValue)
                        .background(backgroundView())
                    
                    Label("Lightning", systemImage: "bolt.fill")
                        .tabItem {
                            Label("Relationship", systemImage: "heart.fill")
                        }
                        .tag(TabSelection.Relationship.rawValue)
                        .background(backgroundView())
                    
                    Label("Lightning", systemImage: "bolt.fill")
                        .tabItem {
                            Label("Finance", systemImage: "dollarsign.ring")
                        }
                        .tag(TabSelection.Finance.rawValue)
                    
                    Label("Lightning", systemImage: "bolt.fill")
                        .tabItem {
                            Label("Upkeep", systemImage: "basket.fill")
                        }
                        .tag(TabSelection.Upkeep.rawValue)
                    
                    Label("Lightning", systemImage: "bolt.fill")
                        .tabItem {
                            Label("Settings", systemImage: "slider.horizontal.2.square")
                        }
                        .tag(TabSelection.Upkeep.rawValue)
                }
                .ignoresSafeArea()
            }.tint(.yellow)
            
//            Circle().fill(.green).frame(width: 100)
        }
    }
    
    /// Chooses different colors for different tabs
    private func backgroundView() -> some View {
        let gradientColors: [Color]
        
        switch selection {
        case TabSelection.Home.rawValue:
            gradientColors = [Color.pink.opacity(0.7), Color("maroon").opacity(0.9)]
        case TabSelection.Relationship.rawValue:
            gradientColors = [Color.pink.opacity(0.9), Color.purple.opacity(0.7)]
        case TabSelection.Finance.rawValue:
            gradientColors = [Color.orange.opacity(0.8), Color.yellow.opacity(0.6)]
        case TabSelection.Upkeep.rawValue:
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

//struct ChatMenuView: View {
//    var body: some View {
//        Text("Chat Menu")
//            .navigationTitle("Chat")
//    }
//}
 
// .toolbar {
// ToolbarItem(placement: .bottomBar) {
// NavigationLink(destination: ChatMenuView()) {
// Image(systemName: "message.fill")
// .foregroundColor(.gray)
// }.padding(.top, 10)
// }
// ToolbarItem(placement: .bottomBar) {
// NavigationLink(destination: ChatMenuView()) {
// Image(systemName: "camera.badge.ellipsis")
// .foregroundColor(.gray)
// }.padding(.top, 10)
// }
// ToolbarItem(placement: .bottomBar) {
// NavigationLink(destination: ChatMenuView()) {
// Image(systemName: "phone.badge.waveform")
// .foregroundColor(.gray)
// }.padding(.top, 10)
// }
// }
 
