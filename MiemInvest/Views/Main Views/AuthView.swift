//
//  AuthView.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 03.05.2022.
//

import SwiftUI

struct AuthView: View {
    
    @ObservedObject var signInViewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        self.signInViewModel = viewModel
    }
    
    var body: some View {
        if self.signInViewModel.loading {
            ProgressView()
                .zIndex(0)
        }
        VStack(spacing: 100) {
            Spacer()
            Image("icon_transparent")
                .resizable()
                .frame(width: 250, height: 180)
            Button {
                signInViewModel.signIn()
            } label: {
                HStack(spacing: 5) {
                    Spacer()
                    Image("microsoft_logo")
                        .resizable()
                        .frame(width: 21, height: 21)
                    
                    Text("Войти с Microsoft")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .semibold))
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .clipShape(Capsule())
            }
            Spacer()

        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.145, green: 0.455, blue: 0.9), Color(red: 0.145, green: 0.455, blue: 0.9), Color(red: 0.094, green: 0.286, blue: 0.666)]), startPoint: .top, endPoint: .bottom))
        
    }
    
    func signInAction() {
        signInViewModel.signIn()
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignInViewModel()
        AuthView(viewModel: viewModel)
    }
}
