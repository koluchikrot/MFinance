//
//  InstrumentRow.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI

struct InstrumentRow: View {
    let instrument: Instrument
    
    var body: some View {
        HStack{
            CircleImage(image: instrument.image)
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
    //                    .font(.title)
                        .foregroundColor(.green)
                } else if index < 40 {
                    Image(systemName: "arrowtriangle.down.fill")
    //                    .font(.title)
                        .foregroundColor(.red)
                } else {
                    Image(systemName: "minus")
    //                    .font(.title)
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
