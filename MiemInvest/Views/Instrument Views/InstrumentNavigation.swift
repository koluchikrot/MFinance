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
    let screenWidth = screenSize.width
    let navBarColor = Color.white
    
    @State private var selection: Tab = .index
    
    var instrument: Instrument
    
    enum Tab {
        case index
        case forecasts
        case news
    }
    
    init(instrument: Instrument) {
        self.instrument = instrument
        
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundEffect = .none
        appearance.backgroundColor = UIColor.clear
            
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack {
            // content
            Group {
                VStack {
                    Rectangle()
                        .fill(navBarColor)
                        .frame(width: screenWidth, height: 50)
                    switch selection {
                    case .index:
                        InstrumentIndex()
                    case .forecasts:
                        InstrumentForecasts()
                    case .news:
                        InstrumentNews(instrument: instrument)
                    }
                }
            }
            .navigationTitle(instrument.name)
            .navigationBarTitleDisplayMode(.inline)
            
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
                            Section {
                                Picker("About the instrument", selection: $selection){
                                        Text("Index")
                                            .tag(Tab.index)
                                        Text("Forecasts")
                                            .tag(Tab.forecasts)
                                        Text("News")
                                            .tag(Tab.news)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                            .padding(.horizontal, 10)
                        }
                        Spacer()
                    }
                }
            }

        }
    }
}

struct InstrumentNavigation_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentNavigation(instrument: instruments[0])
    }
}
