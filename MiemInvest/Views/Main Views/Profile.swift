//
//  Profile.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 12.05.2022.
//

import SwiftUI

struct Profile: View {
    @ObservedObject var signInViewModel: SignInViewModel
    
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
                        SettingsButton(titleText: "О приложении", iconName: "doc.text.fill")
                    }
                }
                .navigationTitle("Профиль")
                .navigationBarItems(trailing: ExitButton(signInViewModel: signInViewModel))
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(signInViewModel: SignInViewModel())
    }
}

struct ExitButton: View {
    @ObservedObject var signInViewModel: SignInViewModel
    
    var body: some View {
        Button {
            signInViewModel.singOut()
        } label: {
            Image(systemName: "rectangle.portrait.and.arrow.right")
                .foregroundColor(Color.blue)
        }
    }
}
