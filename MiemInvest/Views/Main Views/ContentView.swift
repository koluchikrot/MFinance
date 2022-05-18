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
        case auth
    }
    
    var body: some View {
        TabView(selection: $selection) {
            FavoriteInstruments()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(Tab.favorites)
            LookUp()
                .tabItem {
                    Label("Search", systemImage: "doc.text.magnifyingglass")
                }
                .tag(Tab.lookup)
            LatestNews()
                .tabItem {
                    Label("News", systemImage: "note.text")
                }
                .tag(Tab.news)
            AuthView()
                .tabItem{
                    Label("Auth", systemImage: "person.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
