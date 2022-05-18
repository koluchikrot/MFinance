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
                InstrumentNavigation(instrument: instrument)
            } label: {
                InstrumentRow(instrument: instrument)
                    .padding([.top, .bottom])
            }
        }
        .background(Color.primary
                        .opacity(0.1))
        .cornerRadius(15)
    }
}

struct InstrumentFramed_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        InstrumentFramed(instrument: modelData.instruments[0])
    }
}
