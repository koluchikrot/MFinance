//
//  LookUp.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 20.04.2022.
//

import SwiftUI

struct LookUp: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(searchResults) { instrument in
                        NavigationLink {
                            InstrumentNavigation(instrument: instrument)
                        } label: {
                            InstrumentRow(instrument: instrument)
                        }
                    }
                    .searchable(text: $searchText, prompt: "Search for company")
                    TopInstrument(title: "Top companies", instruments: [instruments[0], instruments[1]])
                }
                .navigationTitle("Look up")
            }
        }
    }
    
    var searchResults: [Instrument] {
        if searchText.isEmpty {
            return []
        } else {
            return instruments.filter { $0.name.contains(searchText) }
        }
    }
}

struct LookUp_Previews: PreviewProvider {
    static var previews: some View {
        LookUp()
    }
}
