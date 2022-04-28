//
//  InstrumentNews.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 27.04.2022.
//

import SwiftUI

struct InstrumentNews: View {
    var instrument: Instrument
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading) {
                    ForEach(news) {newsUnit in
                        NewsRow(news: newsUnit)
                    }
                }
            }
    }
    
    var companyNews: [News] {
        return news.filter { $0.instrumentsId.contains(instrument.id) }
    }
}

struct InstrumentNews_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentNews(instrument: instruments[0])
    }
}
