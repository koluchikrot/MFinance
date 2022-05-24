//
//  InstrumentNews.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 27.04.2022.
//

import SwiftUI

struct InstrumentNews: View {
    
    @ObservedObject var newsModel: NewsViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading) {
                if !newsModel.news.isEmpty {
                    ForEach(newsModel.news) {newsUnit in
                        NewsRow(news: newsUnit)
                    }
                } else {
                    Text("No news published for this instrument yet")
                        .padding(.top)
                }
            }
        }
    }
}

struct InstrumentNews_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentNews(newsModel: NewsViewModel(index: 6, text: "1"))
    }
}
