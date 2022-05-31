//
//  FilterButton.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 30.04.2022.
//

import SwiftUI

struct FilterButton: View {
    var filterLabel: String
    
    var body: some View {
        Text(filterLabel)
            .foregroundColor(Color.primary)
//            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
            .padding()
            .frame(width: 155, height: 125, alignment: .bottomLeading)
            .background(Color("Accent"))
            .cornerRadius(10)
//            .shadow(color: Color("Shadow"), radius: 10.0, x: 0, y: 0.0)
//            .padding([.leading, .top, .bottom])
            .padding(.leading)
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton(filterLabel: "Russian")
    }
}
