//
//  TopInstrument.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI

struct TopInstrument: View {
    var title: String
    var instruments: [Instrument]
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2)
                    .padding(.leading)
                ForEach(instruments) { instrument in
                    NavigationLink {
                        InstrumentNavigation(instrument: instrument)
                    } label: {
                        InstrumentRow(instrument: instrument)
                    }
                }
            }
            .padding([.top, .bottom])
            .background(Color.primary.colorInvert())
            .cornerRadius(15)
            .shadow(color: Color.primary.opacity(0.10), radius: 15.0, x: 0, y: 0.0)
        }
        .padding()
    }
}

struct TopInstrument_Previews: PreviewProvider {
    static var previews: some View {
        TopInstrument(title: "Top company", instruments: [instruments[0]])
    }
}
