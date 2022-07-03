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
                    if modelData.instruments.count == 0 {
                        Text("Упс, кажется, у Вас нет ни одного избранного инструмента!")
                            .multilineTextAlignment(.leading)
                    } else {
                        TopInstrument(title: "Лучшее на сегодня", modelData: ModelData(index: 2, text: ""))
                        Text("Акции")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading)
                        VStack(alignment: .leading, spacing: 25) {
                            ForEach(modelData.instruments) { instrument in
                                NavigationLink {
                                    TopNavigationInstrument(infoModel: InstrumentInfoViewModel(instrumentId: instrument.id))
                                } label: {
                                    InstrumentRow(instrument: instrument)
                                }
                            }
                        }
                        Spacer()
                    }
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
