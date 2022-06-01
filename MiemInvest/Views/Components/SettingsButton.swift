//
//  SettingsButton.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 31.05.2022.
//

import SwiftUI

struct SettingsButton: View {
    var titleText: String
    var iconName: String
    
    var body: some View {
        HStack (spacing: 10) {
            Image(systemName: iconName)
                .foregroundColor(Color("Accent"))
                .font(.title)
            Text(titleText)
                .foregroundColor(.primary)
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
        }
        .padding()
        .frame(height: 100)
        .background(Color("Background"))
        .cornerRadius(10)
        .shadow(color: Color("Shadow"), radius: 15.0, x: 0, y: 0.0)
        .padding([.horizontal, .top])
        
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(titleText: "Settings", iconName: "gearshape.fill")
    }
}
