//
//  InstrumentNavigation.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 25.04.2022.
//

import SwiftUI
import UIKit

let screenSize = UIScreen.main.bounds

struct InstrumentNavigation: View {
    @EnvironmentObject var modelData: ModelData
    var instrument: Instrument
    
    var insrtumentIndex: Int {
            modelData.instruments.firstIndex(where: { $0.id == instrument.id })!
    }
    
    @State private var selection: Tab = .index
    
    @State var selectedIndex: Int = 0
    
    let screenWidth = screenSize.width
    let navBarColor = Color.blue.opacity(0.3)
    
    enum Tab {
        case index
        case forecasts
        case news
    }
    
//    init(instrument: Instrument) {
//        self.instrument = instrument
//
//        let appearance = UINavigationBarAppearance()
//        appearance.shadowColor = .clear
//        appearance.backgroundEffect = .none
//        appearance.backgroundColor = UIColor.clear
//
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//    }
    
    var body: some View {
        ZStack {
            // content
            Group {
                VStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: screenWidth, height: 45)
//                    switch selection {
//                    case .index:
//                        InstrumentIndex()
//                    case .forecasts:
//                        InstrumentForecasts()
//                    case .news:
//                        InstrumentNews(instrument: instrument, newsModel: NewsViewModel(index: 6, text: instrument.id))
//                    }
//                    switch selectedIndex {
//                    case 0:
//                        InstrumentIndex()
//                    case 1:
//                        InstrumentForecasts()
//                    case 2:
//                        InstrumentNews(newsModel: NewsViewModel(index: 6, text: instrument.id))
//                    default:
//                        InstrumentIndex()
//                    }
                }
            }
            .navigationTitle(instrument.name)
            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarItems(trailing: FavoriteButton(isSet: $modelData.instruments[insrtumentIndex].isFavorite))
            
            // navigation tab
            Group {
                ZStack {
                    VStack {
                        Rectangle()
                            .fill(navBarColor)
                            .frame(width: screenWidth, height: 138)
                        Spacer()
                    }
                    .edgesIgnoringSafeArea(.all)
                    VStack {
                        ZStack {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: screenWidth, height: 50)
//                            Section {
//                                Picker("About the instrument", selection: $selection){
//                                        Text("Index")
//                                            .tag(Tab.index)
//                                        Text("Forecasts")
//                                            .tag(Tab.forecasts)
//                                        Text("News")
//                                            .tag(Tab.news)
//                                }
//                                .pickerStyle(SegmentedPickerStyle())
                                SegmentedControl(selectedIndex: $selectedIndex, titles: ["Index", "Forecast", "News"])
//                            }
//                            .padding(.horizontal, 10)
                        }
//                        Spacer()
                    }
                }
            }

        }
    }
}

struct InstrumentNavigation_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        InstrumentNavigation(instrument: modelData.instruments[0])
            .environmentObject(modelData)
    }
}
