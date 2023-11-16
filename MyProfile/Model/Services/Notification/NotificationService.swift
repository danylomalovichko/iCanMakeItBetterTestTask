//
//  NotificationService.swift
//  OfficeHours
//
//  Created by Danylo Malovichko on 21.01.2021.
//

import Combine
import UIKit.UIApplication

@MainActor
protocol NotificationService {
    var isNotificationsAuthorized: CurrentValueSubject<Bool?, Never> { get }
    func registerForRemoteNotifications(application: UIApplication) async -> Bool
    func reloadAuthorizedStatus() async 
}

class NotificationManager: NSObject, NotificationService {
    
    private let center = UNUserNotificationCenter.current()
    let isNotificationsAuthorized = CurrentValueSubject<Bool?, Never>(nil)
    
    override init() {
        super.init()
        Task {
            await self.reloadAuthorizedStatus()
        }
    }
    
    func registerForRemoteNotifications(application: UIApplication) async -> Bool {
        let result: Bool = await withCheckedContinuation { continuation in
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            self.center.requestAuthorization(options: authOptions) { result, error in
                if let error {
                    print(error)
                    continuation.resume(returning: false)
                    return
                }
                continuation.resume(returning: result)
            }
            application.registerForRemoteNotifications()
        }
        isNotificationsAuthorized.value = result
        return result
    }
    
    func reloadAuthorizedStatus() async {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        let status = settings.authorizationStatus
        isNotificationsAuthorized.value = status == .authorized
    }
}
