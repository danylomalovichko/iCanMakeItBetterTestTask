//
//  RootView.swift
//  MyProfile
//
//  Created by Danylo Malovichko on 16.11.2023.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HomeView(vm: .init(appState.container))
    }
}

