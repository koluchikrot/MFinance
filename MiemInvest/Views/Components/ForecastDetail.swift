//
//  ForecastDetail.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 27.04.2022.
//

import SwiftUI

struct ForecastDetail: View {
    var type: String
    var certainty: String
    var prediction: String
    var date: String
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                Text(type.firstUppercased)
                    .font(.title2)
                    .padding(.leading)
                Divider()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Price change")
                            .foregroundColor(.secondary)
                        Text(prediction.firstUppercased)
                    }
                    .padding([.leading])
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Certainty")
                            .foregroundColor(.secondary)
                        Text(certainty)
                    }
                    .padding(.trailing)
                }
            }
            .padding([.top, .bottom])
            .background(Color("Background"))
            .cornerRadius(10)
            .shadow(color: Color("Shadow"), radius: 15.0, x: 0, y: 0.0)
        }
        .padding()
    }
}

struct ForecastDetail_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDetail(type: "Barrier", certainty: "47,00", prediction: "UP", date: "2022-05-20")
    }
}

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst().lowercased() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst().lowercased() }
}
