//
//  MenuView.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 21.05.2022.
//

import SwiftUI

struct MenuView: View {
    @State private var selection: Tab = .favorites
    
    enum Tab {
        case favorites
        case lookup
        case news
        case auth
    }
    
    @ObservedObject var signInViewModel: SignInViewModel
    @ObservedObject var favoriteData = ModelData()
    
    var body: some View {
        TabView(selection: $selection) {
            FavoriteInstruments()
                .environmentObject(favoriteData)
                .tabItem {
                    Label("Избранное", systemImage: "star")
                }
                .tag(Tab.favorites)
            LookUp()
                .environmentObject(favoriteData)
                .tabItem {
                    Label("Поиск", systemImage: "doc.text.magnifyingglass")
                }
                .tag(Tab.lookup)
            LatestNews()
                .environmentObject(favoriteData)
                .tabItem {
                    Label("Новости", systemImage: "note.text")
                }
                .tag(Tab.news)
            Profile(signInViewModel: signInViewModel)
                .tabItem {
                    Label("Профиль", systemImage: "person.fill")
                }
                .tag(Tab.auth)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(signInViewModel: SignInViewModel())
            .environmentObject(ModelData())
    }
}
