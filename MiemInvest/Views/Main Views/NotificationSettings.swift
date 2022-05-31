//
//  NotificationSettings.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 31.05.2022.
//

import SwiftUI

struct NotificationSettings: View {
    @State var showNotificationSettingsUI = false
    
    var body: some View {
        VStack {
            Toggle("Я хочу получать уведомления", isOn: $showNotificationSettingsUI)
                .toggleStyle(.switch)
                .onChange(of: showNotificationSettingsUI) { value in
                    // action...
                    if value {
                        NotificationManager.shared.requestAuthorization { granted in
                            // 2
                            if granted {
//                                showNotificationSettingsUI = true
                                NotificationManager.shared.createNotification()
                                print("Created notification")
                            }
                        }
                    } else {
                        NotificationManager.shared.removeNotification()
                        print("Removed notification")
                    }
                }
                .padding()
            Spacer()
        }
        .navigationTitle("Настройки")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NotificationSettings_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSettings()
    }
}
