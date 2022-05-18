//
//  AuthView.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 03.05.2022.
//

import SwiftUI

struct AuthView: View {
    @StateObject var viewModel = SignInViewModel()
    
    var body: some View {
        Button {
            viewModel.signIn()
        } label: {
            Text("Sign In")
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
