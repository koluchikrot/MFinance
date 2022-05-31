//
//  InstrumentInfoView.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 24.05.2022.
//

import SwiftUI

struct InstrumentInfoView: View {
    @ObservedObject var infoModel: InstrumentInfoViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                if let ticker = infoModel.instrumentInfo!.ticker {
                    Text(ticker)
                        .foregroundColor(Color.secondary)
                }
                if let description = infoModel.instrumentInfo!.description {
                    Text(description)
                }
                HStack {
                    Text("Цена")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    if let price = infoModel.instrumentInfo!.price {
                        Text(price)
                            .font(.title2)
                    }
                }
                HStack {
                    Text("Страна")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    if let country = infoModel.instrumentInfo!.country {
                        Text(country)
                            .font(.title2)
                    }
                }
            }
            .padding()
        }
    }
}

struct InstrumentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentInfoView(infoModel: InstrumentInfoViewModel(instrumentId: "1"))
    }
}
