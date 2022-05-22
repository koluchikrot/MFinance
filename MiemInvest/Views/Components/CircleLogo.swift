//
//  CircleLogo.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 21.05.2022.
//

import SwiftUI

struct CircleLogo: View {
    var letter: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.random)
            
            Text(letter)
                .font(.title2)
                .foregroundColor(Color.white)
        }
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct CircleLogo_Previews: PreviewProvider {
    static var previews: some View {
        CircleLogo(letter: "A")
    }
}
