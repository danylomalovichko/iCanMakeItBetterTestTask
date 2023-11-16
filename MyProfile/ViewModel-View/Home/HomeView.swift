//
//  HomeView.swift
//  MyProfile
//
//  Created by Danylo Malovichko on 16.11.2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm: HomeVM
    @State private var selectedTab = 0

    var body: some View {
        TabView {
            ProfileView(vm: .init(vm.container))
                .tabItem {
                    Image("Home")
                    Text("Home")
                }
                .tag(0)
            
            tabBarView()
                .tabItem {
                    Image("Movie")
                    Text("Watching")
                }
                .tag(1)
            
            tabBarView()
                .tabItem {
                    Image("Hashtag")
                    Text("Feedback")
                }
                .tag(2)
            
            tabBarView()
                .tabItem {
                    Image("User")
                    Text("Profile")
                }
                .tag(3)
        }
        .tint(Color(hex: "#C7C7CC"))
        .onAppear() {
            UITabBar.appearance().backgroundColor = UIColor(red: 0.086, green: 0.086, blue: 0.086, alpha: 0.2)
            UITabBar.appearance().unselectedItemTintColor = .gray
        }
    }
}

extension HomeView {
    @ViewBuilder private func tabBarView() -> some View {
        Color.clear
            .background {
                LinearGradient(gradient: Gradient(colors: [Color.regularPurple, Color.darkerPurple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .opacity(0.4)
                    .ignoresSafeArea()
            }
            .background {
                Color.backgroundColor.ignoresSafeArea()
            }
    }
}
