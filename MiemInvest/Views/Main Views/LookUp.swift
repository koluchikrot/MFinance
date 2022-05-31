//
//  LookUp.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 20.04.2022.
//

import SwiftUI

struct LookUp: View {
    @State private var searchText = ""
    
    @ObservedObject var modelData = ModelData(index: 4, text: "")
    @ObservedObject var filterViewModel = FilterViewModel()
    
    @EnvironmentObject var favoriteData: ModelData
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(modelData.instruments) { instrument in
                        NavigationLink {
                            TopNavigationInstrument(infoModel: InstrumentInfoViewModel(instrumentId: instrument.id))
                        } label: {
                            InstrumentRow(instrument: instrument)
                        }
                    }
                    .searchable(text: $modelData.searchString, prompt: "Название, ключевое слово etc")
                    
                    if modelData.searchString == "" {
                        Text("По категориям")
                            .foregroundColor(.primary)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(filterViewModel.filters, id: \.key) { filter in
                                    NavigationLink {
                                        FilteredInstruments(categoryName: filter.value, modelData: ModelData(index: 3, text: filter.key))
    //                                        .environmentObject(favoriteData)
                                    } label: {
                                        FilterButton(filterLabel: filter.value)
                                    }
                                }
                            }
                            .listRowInsets(EdgeInsets())
                        }
                        TopInstrument(title: "Рекомендуем", modelData: ModelData(index: 1, text: ""))
    //                        .environmentObject(favoriteData)
                    }
                }
                .navigationTitle("Поиск")
            }
        }
    }
    
    var searchResults: [Instrument] {
        if searchText.count < 4 {
            return []
        } else {
            return ModelData(index: 4, text: searchText).instruments
        }
    }
}

struct LookUp_Previews: PreviewProvider {
    static var previews: some View {
        LookUp()
    }
}
