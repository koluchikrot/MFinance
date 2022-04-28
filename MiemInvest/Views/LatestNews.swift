//
//  LatestNews.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 19.04.2022.
//

import SwiftUI

struct LatestNews: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading) {
                    ForEach(news) {newsUnit in
                        NewsRow(news: newsUnit)
                    }
                }
                .navigationTitle("Latest news")
            }
        }
    }
}

struct LatestNews_Previews: PreviewProvider {
    static var previews: some View {
        LatestNews()
    }
}