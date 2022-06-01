//
//  InstrumentNews.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 27.04.2022.
//

import SwiftUI

struct InstrumentNews: View {
    @EnvironmentObject var favoriteData: ModelData
    
    @ObservedObject var newsModel: NewsViewModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading) {
                if !newsModel.news.isEmpty {
                    ForEach(newsModel.news) {newsUnit in
                        NewsRow(news: newsUnit)
                            .environmentObject(favoriteData)
                    }
                } else {
                    Text("По данному инструменту еще нет публикаций")
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
