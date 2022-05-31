//
//  NewsRow.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 19.04.2022.
//

import SwiftUI

struct NewsRow: View {
    var news: News
    
    @EnvironmentObject var favoriteData: ModelData
    
    @State var isCropped: Bool = true
    
    var body: some View {
        HStack(alignment: .top) {
            if news.sentiment == "0" {
                ZStack {
                    Circle()
                        .fill(Color.red.opacity(0.2))
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                .frame(width: 33, height: 33)
            }
            else if news.sentiment == "1" {
                ZStack {
                    Circle()
                        .fill(Color.yellow.opacity(0.2))
                    Text("-")
                        .font(.title)
                        .foregroundColor(.yellow)
                }
                .frame(width: 33, height: 33)
            } else if news.sentiment == "2" {
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.2))
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                .frame(width: 33, height: 33)
            }
            VStack (alignment: .leading, spacing: 10) {
                
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
                
                if shouldBeCropped {
                    VStack(alignment: .leading, spacing: 3) {
                        if isCropped {
                            Text(news.fullText)
                                .frame(height: 152, alignment: .top)
                                .truncationMode(.tail)
                        } else {
                            Text(news.fullText)
                        }
                        
                        Button {
                            isCropped.toggle()
                        } label: {
                            if isCropped {
                                Text("Показать больше")
                                    .foregroundColor(Color.blue)
                                    .fontWeight(.bold)
                            } else {
                                Text("Показать меньше")
                                    .foregroundColor(Color.blue)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                } else {
                    Text(news.fullText)
                }
                
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
                HStack {
                    ForEach(news.instruments) { instrument in
                        InstrumentFramed(instrument: instrument)
                            .environmentObject(favoriteData)
                    }
                }
            }
            
        }
        .padding()
    }
    
    var sentimentText: Text {
        if news.sentiment == "0" {
            return Text(Image(systemName: "arrowtriangle.down.fill"))
                .font(.headline)
                .foregroundColor(.red)
        }
        else if news.sentiment == "1" {
            return Text(Image(systemName: "diamond.fill"))
                .font(.headline)
                .foregroundColor(.yellow)
        } else {
            return Text(Image(systemName: "arrowtriangle.up.fill"))
                .font(.headline)
                .foregroundColor(.green)
        }
    }
    
    var shouldBeCropped: Bool {
        return news.fullText.count > 300 ? true : false
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(news: NewsViewModel().news[0])
    }
}
