//
//  InstrumentFramed.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 19.04.2022.
//

import SwiftUI

struct InstrumentFramed: View {
    var instrument: Instrument
    
    var body: some View {
        ZStack {
            NavigationLink {
                TopNavigationInstrument(infoModel: InstrumentInfoViewModel(instrumentId: instrument.id))
            } label: {
                HStack(alignment: .center, spacing: 5) {
                    if let ticker = instrument.ticker {
                        Text(ticker)
                            .foregroundColor(Color.primary)
                            .font(.headline)
                    }
                    if let index = instrument.index {
                        if index >= 50 {
                            Image(systemName: "arrowtriangle.up.fill")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "arrowtriangle.down.fill")
                                .font(.subheadline)
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding()
                .frame(width: 100, height: 100, alignment: .bottomLeading)
            }
        }
        .background(Color("Background"))
        .cornerRadius(10)
        .shadow(color: Color("Shadow"), radius: 15.0, x: 0, y: 0.0)
    }
}

struct InstrumentFramed_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        InstrumentFramed(instrument: modelData.instruments[0])
    }
}
