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
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            NavigationLink {
                                FilteredInstruments(categoryName: "Russian")
                            } label: {
                                FilterButton(filterLabel: "Russian")
                            }
                            FilterButton(filterLabel: "American")
                            FilterButton(filterLabel: "Chinese")
                            FilterButton(filterLabel: "Latin")
                            FilterButton(filterLabel: "German")
                        }
                        .listRowInsets(EdgeInsets())
                    }
//                    TopInstrument(title: "Recomendations", instruments: [ModelData().instruments[0], ModelData().instruments[1]])
                }
                .navigationTitle("Look up")
            }
        }
    }
    
    var searchResults: [Instrument] {
        if searchText.isEmpty {
            return []
        } else {
            return ModelData().instruments.filter { $0.name.contains(searchText) }
        }
    }
}

struct LookUp_Previews: PreviewProvider {
    static var previews: some View {
        LookUp()
    }
}
