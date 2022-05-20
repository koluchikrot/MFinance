//
//  AuthView.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 03.05.2022.
//

import SwiftUI

struct AuthView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if self.viewModel.loading {
            ProgressView()
                .zIndex(0)
        }
        VStack {
            Text("Welcome to")
                .font(.title)
            Text("MiemInvest")
                .font(.title2)
            Button {
                viewModel.signIn()
            } label: {
                HStack(spacing: 5) {
                    Spacer()
                    
                    Image("microsoft_logo")
                    
                    Text("Sign in with Microsoft")
                        .foregroundColor(.primary)
                        .font(.system(size: 15, weight: .semibold))
                    
                    Spacer()
                }
            }

        }
        
    }
    
    func signInAction() {
        viewModel.signIn()
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignInViewModel()
        AuthView(viewModel: viewModel)
    }
}
