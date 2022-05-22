//
//  NewsViewModel.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 22.05.2022.
//

import Foundation
import Combine

final class NewsViewModel: ObservableObject {
    @Published var indexEndpoint: Int = 0
    @Published var searchString: String = "RU"
    
    @Published var news = [News]()
    
    private var validString: AnyPublisher<String, Never> {
        $searchString
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    init(index: Int = 5, text: String = "RU") {
        self.indexEndpoint = index
        self.searchString = text
        
        Publishers.CombineLatest($indexEndpoint, validString)
            .flatMap { (indexEndpoint, search) -> AnyPublisher<[News], Never> in
                self.news = [News]()
                return InstrumentApi.shared.fetchNews(from: Endpoint(index: indexEndpoint, text: search)!)
            }
            .assign(to: \.news, on: self)
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
}
