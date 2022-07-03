//
//  ImageLoader.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 01.06.2022.
//

import Foundation
import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    // input
    @Published var attachmentId: String
    // output
    @Published var image: UIImage?
    
    init(attachmentId: String) {
        self.attachmentId = attachmentId
        let stringURL = "http://172.20.10.4:8443/api/file?fileId=" + attachmentId
        
        $attachmentId
            .flatMap { (path) -> AnyPublisher<UIImage?, Never> in
               self.fetchImage(for: URL(string: stringURL))
            }
            .assign(to: \.image, on: self)
            .store(in: &self.cancellableSet)
    }
    private var cancellableSet: Set<AnyCancellable> = []
    
    private func fetchImage(for url: URL?)
                            -> AnyPublisher <UIImage?, Never> {
        guard url != nil, image == nil else {
            return Just(nil).eraseToAnyPublisher()
        }
        let defaults = UserDefaults.standard
        guard let basicToken = defaults.value(forKey: "jsonwebtoken") else {
            return Just(nil).eraseToAnyPublisher()
        }
                                
        let headers = [
            "Authorization": "Bearer \(basicToken)",
        ]
                                
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        request.allHTTPHeaderFields = headers
                                
        return URLSession.shared.dataTaskPublisher(for: request)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
    }
    
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}

