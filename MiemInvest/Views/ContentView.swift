//
//  ContentView.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .favorites
    
    enum Tab {
        case favorites
        case lookup
        case news
    }
    
    var body: some View {
        TabView(selection: $selection) {
            FavoriteInstruments()
                .tabItem {
                    Label("Favorites", systemImage: "star")
//                        .labelStyle(.iconOnly)
                }
                .tag(Tab.favorites)
            LookUp()
                .tabItem {
                    Label("Search", systemImage: "doc.text.magnifyingglass")
//                        .labelStyle(.iconOnly)
                }
                .tag(Tab.lookup)
            LatestNews()
                .tabItem {
                    Label("News", systemImage: "note.text")
//                        .labelStyle(.iconOnly)
                }
                .tag(Tab.news)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
