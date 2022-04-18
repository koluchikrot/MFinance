//
//  InstrumentList.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI

struct InstrumentList: View {
    var instruments: [Instrument]
    var body: some View {
        List(instruments, id: \.id) { instrument in
            InstrumentRow(instrument: instrument)
        }
    }
}

struct InstrumentList_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentList(instruments: instruments)
    }
}
