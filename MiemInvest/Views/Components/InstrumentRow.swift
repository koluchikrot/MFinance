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
//            CircleLogo(letter: firstLetter)
            CircleImage(imageLoader: ImageLoader(attachmentId: instrument.attachmentId!))
                .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 5){
                Text(instrument.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                    .frame(height: UIFont.preferredFont(forTextStyle: .subheadline).lineHeight)
                    .truncationMode(.tail)
                if let ticker = instrument.ticker {
                    Text(ticker)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.leading, 10)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 5){
                if let price = instrument.price {
                    Text(price)
                        .foregroundColor(.primary)
                }
                if let index = instrument.index {
                    if index >= 50 {
                        HStack(alignment: .center, spacing: 2) {
                            Text("\(index)")
                            Image(systemName: "arrow.up.square.fill")
                        }
                        .font(.subheadline)
                        .foregroundColor(.green)
                    } else if index < 50 {
                        HStack(alignment: .center, spacing: 2) {
                            Text("\(index)")
                            Image(systemName: "arrow.down.square.fill")
                        }
                        .font(.subheadline)
                        .foregroundColor(.red)
                    } else {
                        Image(systemName: "minus")
                            .foregroundColor(.primary)
                    }
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
