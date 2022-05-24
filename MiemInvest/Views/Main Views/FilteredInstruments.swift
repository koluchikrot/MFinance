//
//  FilteredInstruments.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 01.05.2022.
//

import SwiftUI

struct FilteredInstruments: View {
    var categoryName: String
    @ObservedObject var modelData: ModelData
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(modelData.instruments) { instrument in
                    NavigationLink {
                        TopNavigationInstrument(infoModel: InstrumentInfoViewModel(instrumentId: instrument.id))
                    } label: {
                        InstrumentRow(instrument: instrument)
                    }
                }
                Spacer()
            }
            .navigationTitle(categoryName)
        }
    }
}

struct FilteredInstruments_Previews: PreviewProvider {
    static var previews: some View {
        FilteredInstruments(categoryName: "Russian", modelData: ModelData(index: 3, text: "RUSSIAN"))
    }
}
