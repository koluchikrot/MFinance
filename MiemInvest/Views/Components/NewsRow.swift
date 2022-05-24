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
        VStack (alignment: .leading, spacing: 10) {
            HStack {
                HStack {
                    Text(news.source)
                    
                    Text("|")
                    
                    if let publishedDate = news.publishedDate {
                        if Calendar.current.isDateInToday(publishedDate) {
                            let calendar = Calendar.current
                            let hour = calendar.component(.hour, from: publishedDate)
                            let minute = calendar.component(.minute, from: publishedDate)
                            Text("\(hour):\(minute), Today")
                        }
                        else {
                            Text(publishedDate.formatted())
                        }
                    } else {
                        Text(Date(timeIntervalSinceNow: -3000).formatted())
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
            }
            .foregroundColor(.secondary)
            
            if let url = URL(string: news.link) {
                Link(destination: url){
                    Text(news.header)
                        .font(.headline)
                        .foregroundColor(Color.primary)
                        .multilineTextAlignment(.leading)
                }
            } else {
                Text(news.header)
                    .font(.headline)
            }
            
            Text(news.fullText)
            
            HStack {
                ForEach(news.instruments) { instrument in
                    InstrumentFramed(instrument: instrument)
                }
            }
        }
        .padding()
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(news: NewsViewModel().news[0])
    }
}
