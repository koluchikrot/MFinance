//
//  FavoriteButton.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 29.04.2022.
//

import SwiftUI

struct FavoriteButton: View {
    @EnvironmentObject var modelData: ModelData
    @State var isSet: Bool
    var instrumentId: String
    
    var body: some View {
        Button {
            buttonPressed()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .foregroundColor(isSet ? .blue : .gray)
        }
    }
    
    var absoluteUrl: URL? {
        guard let queryUrl = URL(string: "http://172.20.10.4:8443/api/user/favorites") else {
            return nil
        }
        let components = URLComponents(url: queryUrl, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else {
            return nil
        }
        let queryAuthCode = URLQueryItem(name: "instrumentId", value: instrumentId)
        urlComponents.queryItems = [queryAuthCode]
        
        return urlComponents.url
    }
    
    func buttonPressed() {
        guard let url = absoluteUrl else { return }
        
        let defaults = UserDefaults.standard
        let basicToken = defaults.value(forKey: "jsonwebtoken")!
        
        let headers = [
            "Authorization": "Bearer \(basicToken)",
        ]
        
        var request = URLRequest(url: url)
        if isSet {
            request.httpMethod = "DELETE"
        } else {
            request.httpMethod = "POST"
        }
        request.timeoutInterval = 60
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            showResponse(data)  // <-- for debuging
            guard error == nil else { print("--> error: \(error)"); return }
            guard data != nil else { print("empty data"); return }
        }.resume()
        
//        modelData.reload()
        
        isSet.toggle()
    }
    
    func showResponse(_ data: Data?) {
        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers), let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print("\n---> response: " + String(decoding: jsonData, as: UTF8.self))
        } else {
            print("=========> error")
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: true, instrumentId: "1")
    }
}
