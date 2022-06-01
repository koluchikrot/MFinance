//
//  NotificationManager.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 30.05.2022.
//

import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    @Published var settings: UNNotificationSettings?
    
    func requestAuthorization(completion: @escaping  (Bool) -> Void) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
                self.fetchNotificationSettings()
                completion(granted)
            }
    }
    func fetchNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        DispatchQueue.main.async {
          self.settings = settings
        }
      }
    }
    
    func createNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Топ инструмент"
        content.body = "Какой инструмент в топе сегодня?"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.hour = 20
        dateComponents.minute = 37
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "1",
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
               print("Cannot create a notification request")
           }
        }

    }
    
    func removeNotification() {
        UNUserNotificationCenter.current()
          .removePendingNotificationRequests(withIdentifiers: ["1"])
    }
    
}
