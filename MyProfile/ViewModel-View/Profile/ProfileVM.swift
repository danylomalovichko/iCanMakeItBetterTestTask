//
//  ProfileVM.swift
//  MyProfile
//
//  Created by Danylo Malovichko on 16.11.2023.
//

import Foundation
import Combine
import UIKit

@MainActor
class ProfileVM: BaseVM {
    
    @Published var user = User(name: "", surname: "", username: "")
    @Published var isNotificationsAuthorized = false
    @Published var shareUrl = URL(string: "http://imakebetter.com")!

    override init(_ container: DependencyContainer) {
        
        super.init(container)
        
        container.notifications
            .isNotificationsAuthorized
            .compactMap { $0 }
            .assign(to: &$isNotificationsAuthorized)
        
        Task {
            await requestNotificationsAccess()
        }
  
    }
    
    func requestNotificationsAccess() async {
        let app = UIApplication.shared
        _ = await container.notifications.registerForRemoteNotifications(application: app)
    }
    
    func reloadAuthorizedStatus() {
        Task {
            await container.notifications.reloadAuthorizedStatus()
        }
    }
    
    func updateUserImage(_ image: UIImage) {
        user.image = image
    }
}

