//
//  Profile.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 12.05.2022.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        NavigationView {
            ScrollView (.vertical, showsIndicators: false) {
                VStack {
                    NavigationLink {
                        NotificationSettings()
                    } label: {
                        SettingsButton(titleText: "Настройки", iconName: "gearshape.fill")
                    }
                    NavigationLink {
                        About()
                    } label: {
                        SettingsButton(titleText: "О приложении", iconName: "bell.fill")
                    }
                }
                .navigationTitle("Профиль")
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
