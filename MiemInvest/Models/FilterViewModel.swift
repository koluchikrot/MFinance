//
//  FilterViewModel.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 23.05.2022.
//

import Foundation
import Combine

final class FilterViewModel: ObservableObject {
    @Published var indexEndpoint: Int = 8
    @Published var searchString: String = "RU"
    
    @Published var filters = [Filter]()
    
    private var validString: AnyPublisher<String, Never> {
        $searchString
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    init(){
        self.indexEndpoint = 8
        self.searchString = "text"
        Publishers.CombineLatest($indexEndpoint, validString)
            .flatMap { (indexEndpoint, search) -> AnyPublisher<[Filter], Never> in
                self.filters = [Filter]()
                return InstrumentApi.shared.fetchFilters(from: Endpoint(index: indexEndpoint, text: search)!)
            }
            .assign(to: \.filters, on: self)
            .store(in: &self.cancellableSet)
    }
    private var cancellableSet: Set<AnyCancellable> = []
}
