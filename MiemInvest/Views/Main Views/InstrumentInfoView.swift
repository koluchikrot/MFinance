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
            VStack(alignment: .leading) {
                if let ticker = infoModel.instrumentInfo!.ticker {
                    Text(ticker)
                        .background(Color.primary.opacity(0.1))
                        .foregroundColor(Color.secondary)
                }
                if let price = infoModel.instrumentInfo!.price {
                    Text(price)
                        .font(.title)
                }
                if let country = infoModel.instrumentInfo!.country {
                    ZStack {
                      Circle()
                        .fill(Color.primary.opacity(0.1))
                      Text(country)
                    }
                    .frame(width: 40, height: 40)
                        
                }
                if let description = infoModel.instrumentInfo!.description {
                    Text(description)
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
