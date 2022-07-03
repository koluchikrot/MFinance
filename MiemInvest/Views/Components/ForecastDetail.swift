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
                    .fontWeight(.bold)
                Divider()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Изменение цены")
                            .foregroundColor(.secondary)
                        if prediction.firstUppercased == "0" {
                            Text("Упадет")
                                .fontWeight(.bold)
                        } else if prediction.firstUppercased == "1" {
                            Text("Не изменится")
                                .fontWeight(.bold)
                        } else if prediction.firstUppercased == "2" {
                            Text("Вырастет")
                                .fontWeight(.bold)
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Уверенность")
                            .foregroundColor(.secondary)
                        Text(certainty)
                            .fontWeight(.bold)
                    }
                }
            }
            .padding()
            .background(Color("Background"))
            .cornerRadius(10)
            .shadow(color: Color("Shadow"), radius: 15.0, x: 0, y: 0.0)
        }
        .padding([.horizontal, .top])
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
