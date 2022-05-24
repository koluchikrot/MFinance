//
//  InstrumentForecasts.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 27.04.2022.
//

import SwiftUI

struct InstrumentForecasts: View {
    @ObservedObject var infoModel: InstrumentInfoViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(infoModel.instrumentInfo!.predictions) { prediction in
                ForecastDetail(type: prediction.type, certainty: prediction.certainty, prediction: prediction.prediction, date: prediction.date)
            }
        }
    }
}

struct InstrumentForecasts_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentForecasts(infoModel: InstrumentInfoViewModel(instrumentId: "1"))
    }
}
