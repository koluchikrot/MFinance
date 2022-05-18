//
//  FilteredInstruments.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 01.05.2022.
//

import SwiftUI

struct FilteredInstruments: View {
    var categoryName: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(ModelData().instruments) { instrument in
                    NavigationLink {
                        InstrumentNavigation(instrument: instrument)
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
        FilteredInstruments(categoryName: "Russian")
    }
}
