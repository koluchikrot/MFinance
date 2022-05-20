//
//  FavoriteInstruments.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI

struct FavoriteInstruments: View {
//    @EnvironmentObject var modelData: ModelData
    @ObservedObject var modelData = ModelData()
    
    var favoriteInstruments: [Instrument] { modelData.instruments.filter { instrument in
            instrument.isFavorite
        }
    }
    
    init() {
        let appearance = UINavigationBarAppearance()
//        appearance.shadowColor = .clear
//        appearance.backgroundEffect = .none
//        appearance.backgroundColor = .primary
            
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading) {
//                    TopInstrument(title: "Top company for today", instruments: [modelData.instruments[0]])
                    Text("Stocks")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading)
                    ForEach(modelData.instruments) { instrument in
                        NavigationLink {
                            InstrumentNavigation(instrument: instrument)
                        } label: {
                            InstrumentRow(instrument: instrument)
                        }
                    }
                    Spacer()
                }
                .navigationTitle("Favorites")
            }
        }
    }
}

struct FavoriteInstruments_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        FavoriteInstruments()
            .environmentObject(modelData)
    }
}
