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
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading) {
                    TopInstrument(title: "Топ инструмент на сегодня", modelData: ModelData(index: 2, text: ""))
//                        .environmentObject(modelData)
                    Text("Акции")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading)
                    ForEach(modelData.instruments) { instrument in
                        NavigationLink {
                            TopNavigationInstrument(infoModel: InstrumentInfoViewModel(instrumentId: instrument.id))
//                                .environmentObject(modelData)
                        } label: {
                            InstrumentRow(instrument: instrument)
                        }
                    }
                    Spacer()
                }
                .navigationTitle("Избранное")
            }
        }
        .onAppear {
            modelData.reload()
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
