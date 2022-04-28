//
//  FavoriteInstruments.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI

struct FavoriteInstruments: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading) {
                    TopInstrument(title: "Top company for today", instruments: [instruments[0]])
                    Text("Stocks")
                        .font(.title2)
                        .padding(.leading)
                    ForEach(instruments) { instrument in
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
    static var previews: some View {
        FavoriteInstruments()
    }
}
