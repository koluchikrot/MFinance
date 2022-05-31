//
//  ContentView.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if self.viewModel.isAuthenticated {
            MenuView()
        } else {
            AuthView(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignInViewModel()
        ContentView(viewModel: viewModel)
            .environmentObject(ModelData())
    }
}
