//
//  AppState.swift
//  MyProfile
//
//  Created by Danylo Malovichko on 16.11.2023.
//

import Foundation

class AppState: ObservableObject {
    @Published var container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
}
