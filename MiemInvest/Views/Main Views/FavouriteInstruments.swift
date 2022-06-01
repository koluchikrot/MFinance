//
//  FavoriteInstruments.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI

struct FavoriteInstruments: View {
    @ObservedObject var modelData = ModelData()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading) {
                    TopInstrument(title: "Топ инструмент на сегодня", modelData: ModelData(index: 2, text: ""))
                    Text("Акции")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading)
                    ForEach(modelData.instruments) { instrument in
                        NavigationLink {
                            TopNavigationInstrument(infoModel: InstrumentInfoViewModel(instrumentId: instrument.id))
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
            self.modelData.objectWillChange.send()
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
