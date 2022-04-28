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
                .frame(width: 45, height: 45)
            VStack(alignment: .leading){
                Text(instrument.name)
                    .foregroundColor(.primary)
                Text("\(instrument.price)$")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if instrument.index > 60 {
                Image(systemName: "arrow.up.right")
                    .font(.title)
                    .foregroundColor(.green)
            } else if instrument.index < 40 {
                Image(systemName: "arrow.down.right")
                    .font(.title)
                    .foregroundColor(.red)
            } else {
                Image(systemName: "minus")
                    .font(.title)
                    .foregroundColor(.primary)
            }
        }
        .padding([.leading, .trailing])
//        .padding([.top, .bottom], 10)
    }
}

struct InstrumentRow_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentRow(instrument: instruments[0])
    }
}
