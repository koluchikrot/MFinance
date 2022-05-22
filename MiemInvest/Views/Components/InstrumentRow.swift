//
//  InstrumentRow.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI

struct InstrumentRow: View {
    let instrument: Instrument
    
    var firstLetter: String {
        return String(instrument.name.prefix(1))
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 5){
            CircleLogo(letter: firstLetter)
                .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 5){
                Text(instrument.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                if let price = instrument.price {
                    Text("\(price)$")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.leading, 10)
            
            Spacer()
            
            if let index = instrument.index {
                if index > 60 {
                    Image(systemName: "arrowtriangle.up.fill")
                        .foregroundColor(.green)
                } else if index < 40 {
                    Image(systemName: "arrowtriangle.down.fill")
                        .foregroundColor(.red)
                } else {
                    Image(systemName: "minus")
                        .foregroundColor(.primary)
                }
            }
        }
        .padding([.leading, .trailing])
//        .padding([.top, .bottom], 10)
    }
}

struct InstrumentRow_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentRow(instrument: ModelData().instruments[0])
    }
}
