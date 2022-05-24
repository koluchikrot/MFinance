//
//  TopInstrument.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI

struct TopInstrument: View {
    var title: String
    @ObservedObject var modelData: ModelData
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title2)
                    .padding([.leading, .bottom])
                ForEach(modelData.instruments) { instrument in
                    NavigationLink {
                        TopNavigationInstrument(infoModel: InstrumentInfoViewModel(instrumentId: instrument.id))
                    } label: {
                        InstrumentRow(instrument: instrument)
                    }
                }
            }
            .padding([.top, .bottom], 20)
            .padding(.horizontal, 5)
            .background(Color("Background"))
            .cornerRadius(10)
            .shadow(color: Color("Shadow"), radius: 15.0, x: 0, y: 0.0)
        }
        .padding()
    }
}

struct TopInstrument_Previews: PreviewProvider {
    static var previews: some View {
        TopInstrument(title: "Top company", modelData: ModelData(index: 2, text: ""))
    }
}
