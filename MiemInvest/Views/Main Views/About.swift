//
//  About.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 25.05.2022.
//

import SwiftUI

struct About: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Чем MiemInvest отличается от других финансовых приложений?")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text("MiemInvest")
                Text("Что такое новостной анализ?")
                    .font(.headline)
                    .fontWeight(.bold)
                Text("Чем отличаются модели Binary и Barier?")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .navigationTitle("О приложении")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
