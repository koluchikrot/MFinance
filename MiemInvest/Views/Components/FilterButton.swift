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
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(Color.primary.colorInvert())
            .clipShape(Capsule())
            .shadow(color: Color.primary.opacity(0.10), radius: 10.0, x: 0, y: 0.0)
            .padding([.leading, .top, .bottom])
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton(filterLabel: "Russian")
    }
}
