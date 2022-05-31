//
//  LatestNews.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 19.04.2022.
//

import SwiftUI

struct LatestNews: View {
    @ObservedObject var newsModel = NewsViewModel()
    
    @EnvironmentObject var favoriteData: ModelData
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack {
                    ForEach(newsModel.news) {newsUnit in
                        NewsRow(news: newsUnit)
                            .environmentObject(favoriteData)
                    }
                }
                .navigationTitle("Новости")
            }
        }
    }
}

struct LatestNews_Previews: PreviewProvider {
    static var previews: some View {
        LatestNews()
    }
}
