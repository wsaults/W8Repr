//
//  SettingsView.swift
//  W8Repr
//
//  Created by Will Saults on 5/9/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var notificationManager = NotificationManager()
    @State private var showingDeleteAlert = false
    @State private var reminderTime: Date
    @State private var showingNotificationPermissionAlert = false
    
    init() {
        _reminderTime = State(initialValue: NotificationManager().getReminderTime())
    }
    
    private var dangerZoneSection: some View {
        Section {
            Button(role: .destructive) {
                showingDeleteAlert = true
            } label: {
                Text("Delete All Weight Entries")
            }
        } header: {
            Text("Danger Zone")
        }
    }
    
    private var reminderSection: some View {
        Section {
            Toggle("Daily Reminder", isOn: $notificationManager.isReminderEnabled)
                .onChange(of: notificationManager.isReminderEnabled) { _, newValue in
                    if newValue {
                        notificationManager.requestNotificationPermission { granted in
                            if !granted {
                                showingNotificationPermissionAlert = true
                            }
                        }
                    } else {
                        notificationManager.disableNotifications()
                    }
                }
            
            if notificationManager.isReminderEnabled {
                DatePicker("Reminder Time",
                          selection: $reminderTime,
                          displayedComponents: .hourAndMinute)
                    .onChange(of: reminderTime) { _, newValue in
                        notificationManager.scheduleNotification(at: newValue)
                        notificationManager.saveReminderTime(newValue)
                    }
            }
        } header: {
            Text("Reminders")
        } footer: {
            Text("You'll receive a notification at the specified time every day to log your weight.")
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                reminderSection
                dangerZoneSection
            }
            .navigationTitle("Settings")
            .alert("Delete All Entries", isPresented: $showingDeleteAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    do {
                        let entries = try modelContext.fetch(FetchDescriptor<RepEntry>())
                        for entry in entries {
                            modelContext.delete(entry)
                        }
                        try modelContext.save()
                        dismiss()
                    } catch {
                        print("Failed to delete entries: \(error)")
                    }
                }
            } message: {
                Text("Are you sure you want to delete all weight entries? This action cannot be undone.")
            }
            .alert("Notifications Disabled", isPresented: $showingNotificationPermissionAlert) {
                Button("OK", role: .cancel) {
                    notificationManager.isReminderEnabled = false
                }
                Button("Open Settings") {
                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsUrl)
                    }
                }
            } message: {
                Text("Please enable notifications in Settings to use daily reminders.")
            }
        }
    }
}
