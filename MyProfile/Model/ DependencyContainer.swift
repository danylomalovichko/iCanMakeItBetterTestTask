//
//  DependencyContainer.swift
//  BikeTask
//
//  Created by Danylo Malovichko on 23.10.2023.
//

import Foundation

@MainActor
class DependencyContainer {
    
   let notifications: NotificationService

    init() {
        notifications = NotificationManager()
    }
}
