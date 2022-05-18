//
//  Oauth2Model.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 02.05.2022.
//

import Foundation
import AuthenticationServices
import Combine

class SignInViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func signIn() {
        guard let authUrl = URL(string: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize?response_type=code&client_id=e0298532-643b-40af-a866-a309039151ea&scope=openid%20email%20profile&state=a6Ko0MHIIeC1YS2iiGPePc6f5v_N0D_hl9qP54Q5tKw%3D&redirect_uri=miem-invest://oauth/callback&nonce=T79MpglFnbgplf4_Kqmk8tHyJkjhbJ6AMlG2xwDizSU") else { return }
        let redirectURL = "miem-invest"
        
        let authSession = ASWebAuthenticationSession(
            url: authUrl, callbackURLScheme:
                redirectURL)
        { url, error in
            guard error == nil, let url = url else { return }
            let queryItems = URLComponents(string: url.absoluteString)?.queryItems
            let authCode = queryItems?.filter({ $0.name == "code" }).first?.value
            
            print(authCode!)
        }
        
        authSession.presentationContextProvider = self
        authSession.prefersEphemeralWebBrowserSession = true
        authSession.start()
        
            
    }
}

public class AnilistAPIConfigurations: Codable {
    public let id: Int
    public let secret: String
    public let name: String
    public let redirectURL: URL
    
    static func load() -> AnilistAPIConfigurations {
        let filePath = Bundle.main.url(forResource: "anilist_api", withExtension: "json")!
        let data = try! Data(contentsOf: filePath)
        let object = try! JSONDecoder().decode(AnilistAPIConfigurations.self, from: data)
        return object
    }
}

/// Builds authentication URLs.
public class AnilistAuthenticationURLBuilder {
    
    /// The domain URL
    let domain: String
    
    /// Client ID
    let clientID: Int
    
    init(
        domain: String = "login.microsoftonline.com",
        clientID: Int) {
        self.domain = domain
        self.clientID = clientID
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = domain
        components.path = "/common/oauth/v2.0/authorize"
        components.queryItems =
            [
                "client_id": String(clientID),
                "response_type": "code"
            ].map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    func callAsFunction() -> URL {
        url
    }
}

