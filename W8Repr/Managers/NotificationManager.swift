//
//  NotificationManager.swift
//  W8Repr
//
//  Created by Will Saults on 5/9/25.
//

import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    @Published var isReminderEnabled = false
    private let reminderTimeKey = "reminderTime"
    
    init() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.isReminderEnabled = settings.authorizationStatus == .authorized
            }
        }
    }
    
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            DispatchQueue.main.async {
                self.isReminderEnabled = granted
                completion(granted)
            }
        }
    }
    
    func scheduleNotification(at time: Date) {
        let center = UNUserNotificationCenter.current()
        
        // Remove existing notifications
        center.removeAllPendingNotificationRequests()
        
        if isReminderEnabled {
            let content = UNMutableNotificationContent()
            content.title = "Time to Log Your Reps!"
            content.body = "Don't forget to log your reps for today!"
            content.sound = .default
            
            // Create date components from the selected time
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute], from: time)
            
            // Create the trigger for daily notification at specified time
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            
            let request = UNNotificationRequest(identifier: "repLogReminder",
                                             content: content,
                                             trigger: trigger)
            
            center.add(request)
        }
    }
    
    func disableNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        isReminderEnabled = false
    }
    
    func saveReminderTime(_ time: Date) {
        UserDefaults.standard.set(time, forKey: reminderTimeKey)
    }
    
    func getReminderTime() -> Date {
        UserDefaults.standard.object(forKey: reminderTimeKey) as? Date ?? Date()
    }
}
