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
                    Text("Stocks")
                        .font(.title2)
                        .padding(.leading)
                    ForEach(instruments) { instrument in
                        InstrumentRow(instrument: instrument)
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
