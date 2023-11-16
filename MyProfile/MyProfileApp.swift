//
//  MyProfileApp.swift
//  MyProfile
//
//  Created by Danylo Malovichko on 15.11.2023.
//

import SwiftUI

@main
struct BikeTaskApp: App {
    
    @StateObject var appState = AppState(container: DependencyContainer())
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
    }
}
