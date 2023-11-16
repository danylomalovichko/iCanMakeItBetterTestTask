//
//  RootVM.swift
//  MyProfile
//
//  Created by Danylo Malovichko on 16.11.2023.
//

import Foundation

@MainActor
class RootVM: ObservableObject {
    let container: DependencyContainer
    
    init(_ container: DependencyContainer) {
        self.container = container
    }
}
