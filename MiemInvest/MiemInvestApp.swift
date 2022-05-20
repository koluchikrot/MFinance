//
//  MiemInvestApp.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI

@main
struct MiemInvestApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            let viewModel = SignInViewModel()
            ContentView(viewModel: viewModel)
                .environmentObject(modelData)
//            ContentView()
//                .environmentObject(modelData)
        }
    }
}
