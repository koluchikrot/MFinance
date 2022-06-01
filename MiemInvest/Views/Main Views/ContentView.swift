//
//  ContentView.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var signInViewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        self.signInViewModel = viewModel
    }
    
    var body: some View {
        if self.signInViewModel.isAuthenticated {
            MenuView(signInViewModel: signInViewModel)
        } else {
            AuthView(viewModel: signInViewModel)
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
