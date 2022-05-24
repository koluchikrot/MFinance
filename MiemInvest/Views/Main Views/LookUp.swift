//
//  LookUp.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 20.04.2022.
//

import SwiftUI

struct LookUp: View {
    @State private var searchText = ""
    
    @ObservedObject var modelData = ModelData(index: 1, text: "")
    @ObservedObject var filterViewModel = FilterViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
//                    ForEach(searchResults) { instrument in
//                        NavigationLink {
//                            TopNavigationInstrument(instrument: instrument)
//                        } label: {
//                            InstrumentRow(instrument: instrument)
//                        }
//                    }
//                    .searchable(text: $searchText, prompt: "Search for company")
                    Text("By category")
                        .foregroundColor(.primary)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(filterViewModel.filters, id: \.key) { filter in
                                NavigationLink {
                                    FilteredInstruments(categoryName: filter.value, modelData: ModelData(index: 3, text: filter.key))
                                } label: {
                                    FilterButton(filterLabel: filter.value)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets())
                    }
                    TopInstrument(title: "Recomendations", modelData: ModelData(index: 1, text: ""))
                }
                .navigationTitle("Look up")
            }
        }
    }
    
    var searchResults: [Instrument] {
        if searchText.isEmpty {
            return []
        } else {
            return modelData.instruments.filter { $0.name.contains(searchText) }
        }
    }
}

struct LookUp_Previews: PreviewProvider {
    static var previews: some View {
        LookUp()
    }
}
