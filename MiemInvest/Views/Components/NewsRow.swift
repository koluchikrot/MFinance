//
//  NewsRow.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 19.04.2022.
//

import SwiftUI

struct NewsRow: View {
    var news: News
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                CircleImage(image: news.image)
                    .frame(width: 38, height: 38)
                VStack(alignment: .leading) {
                    Text(news.source)
                    
                    if let publishedDate = news.publishedDate {
                        if Calendar.current.isDateInToday(publishedDate) {
                            let calendar = Calendar.current
                            let hour = calendar.component(.hour, from: publishedDate)
                            let minute = calendar.component(.minute, from: publishedDate)
                            Text("\(hour):\(minute), Today")
                        }
                        else {
                            Text(publishedDate.formatted())
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    } else {
                        Text(Date(timeIntervalSinceNow: -3000).formatted())
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
            }
            Text(news.header)
                .font(.headline)
                .padding(.top)
                .padding(.bottom, 10)
            Text(news.fullText)
            
            ForEach(news.instrumentsId, id: \.self) { instrumentId in
                if let instrumentId = Int(instrumentId) {
                    InstrumentFramed(instrument: ModelData().instruments[instrumentId - 1])
                }
            }
        }
        .padding()
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(news: news[0])
    }
}
