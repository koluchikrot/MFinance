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
            Rectangle()
                .fill(Color.random)
                .cornerRadius(15)
            
            Text(letter)
                .font(.title2)
                .foregroundColor(Color.white)
        }
    }
}

struct ColorModel: Identifiable {
    let value: Color
    let id = UUID()
}
let colors = [
    ColorModel(value: Color.orange),
    ColorModel(value: Color.green),
    ColorModel(value: Color.blue),
    ColorModel(value: Color.red),
    ColorModel(value: Color.yellow),
    ColorModel(value: Color.indigo),
    ColorModel(value: Color.pink),
    ColorModel(value: Color.teal),
    ColorModel(value: Color.purple)
]

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
    static var randomApproved: Color {
        return colors[.random(in: 0...8)].value
    }
}

struct CircleLogo_Previews: PreviewProvider {
    static var previews: some View {
        CircleLogo(letter: "A")
    }
}
