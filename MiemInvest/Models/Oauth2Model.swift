//
//  Oauth2Model.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 02.05.2022.
//

import Foundation
import AuthenticationServices
import Combine

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct TokenResponse: Codable {
    let token: String?
    let username: String?
}

class SignInViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    
    @Published var isAuthenticated: Bool = false
    @Published var loading: Bool = false
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func signIn() {
        let defaults = UserDefaults.standard
        
        guard let authUrl = URL(string: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize?response_type=code&client_id=e0298532-643b-40af-a866-a309039151ea&scope=openid%20email%20profile&state=a6Ko0MHIIeC1YS2iiGPePc6f5v_N0D_hl9qP54Q5tKw%3D&redirect_uri=miem-invest://oauth/callback&nonce=T79MpglFnbgplf4_Kqmk8tHyJkjhbJ6AMlG2xwDizSU") else { return }
        let redirectURL = "miem-invest"
        
        let authSession = ASWebAuthenticationSession(
            url: authUrl, callbackURLScheme:
                redirectURL)
        { url, error in
            guard error == nil, let url = url else { return }
            let queryItems = URLComponents(string: url.absoluteString)?.queryItems
            let authCode = queryItems?.filter({ $0.name == "code" }).first?.value
            
            guard let authCode = authCode else {
                return
            }
            print(authCode)
            
            self.getToken(code: authCode) { result in
                switch result {
                case .success(let token):
                    print(token)
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.loading = false
                }
            }
        }
        
        authSession.presentationContextProvider = self
        authSession.prefersEphemeralWebBrowserSession = true
        authSession.start()
    }
    
    func getToken(code: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        self.loading = true
        
        guard let queryUrl = URL(string: "http://172.20.10.4:8443/api/login/callback") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let components = URLComponents(url: queryUrl, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else {
            return
        }
        let queryAuthCode = URLQueryItem(name: "code", value: code)
        urlComponents.queryItems = [queryAuthCode]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let tokenResponse = try? JSONDecoder().decode(TokenResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = tokenResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
            
        }.resume()

    }
    
    func singOut() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}
