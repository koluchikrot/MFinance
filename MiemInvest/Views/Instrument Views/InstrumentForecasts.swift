//
//  InstrumentForecasts.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 27.04.2022.
//

import SwiftUI

struct InstrumentForecasts: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForecastDetail()
            ForecastDetail()
        }
    }
}

struct InstrumentForecasts_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentForecasts()
    }
}
