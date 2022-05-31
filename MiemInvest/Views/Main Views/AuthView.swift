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
        VStack(spacing: 30) {
            VStack {
                Text("Приветствуем в")
                    .font(.title)
                Text("MiemInvest")
                    .font(.title2)
            }
            Button {
                viewModel.signIn()
            } label: {
                HStack(spacing: 5) {
                    
                    Image("microsoft_logo")
                        .resizable()
                        .frame(width: 21, height: 21)
                    
                    Text("Войти с Microsoft")
                        .foregroundColor(.primary)
                        .font(.system(size: 15, weight: .semibold))
                }
                .padding()
                .background(Color("Accent"))
                .clipShape(Capsule())
//                .border(Color.primary, width: 2)
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
