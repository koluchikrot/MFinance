//
//  MiemInvestApp.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI
import UserNotifications

@main
struct MiemInvestApp: App {
    
    var body: some Scene {
        WindowGroup {
            let viewModel = SignInViewModel()
            ContentView(viewModel: viewModel)
        }
    }
}
