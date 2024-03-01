//
//  NotificationManager.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/02/2024.
//

import Foundation
import UserNotifications

// NotificationManager is responsible for requesting notification permission and scheduling a daily notification reminder
class NotificationManager: ObservableObject {
    @Published var authorizationStatus: UNAuthorizationStatus?
    
    // request the user's permission and if granted, schedule notifications
    func requestPermission() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    center.getNotificationSettings { newSettings in
                        DispatchQueue.main.async {
                            self.authorizationStatus = newSettings.authorizationStatus
                        }
                    }
                    if granted {
                        self.scheduleNotification()
                    }
                }
            default:
                break
            }
        }
    }
    
    // schedule a notification at 6pm daily
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "It's time to add your journeys!"
        content.body = "Keep it up!"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 18
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
