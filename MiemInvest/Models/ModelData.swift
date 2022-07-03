//
//  ModelData.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var indexEndpoint: Int = 0
    @Published var searchString: String = "RU"
    
    @Published var instruments = [Instrument]()
    
    private var validString: AnyPublisher<String, Never> {
        $searchString
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    init(index: Int = 0, text: String = "RU") {
        self.indexEndpoint = index
        self.searchString = text
        
        Publishers.CombineLatest($indexEndpoint, validString)
            .flatMap { (indexEndpoint, search) -> AnyPublisher<[Instrument], Never> in
                self.instruments = [Instrument]()
                return InstrumentApi.shared.fetchInstruments(from: Endpoint(index: indexEndpoint, text: search)!)
            }
            .assign(to: \.instruments, on: self)
            .store(in: &self.cancellableSet)
    }
    
    func reload() {
        Publishers.CombineLatest($indexEndpoint, validString)
            .flatMap { (indexEndpoint, search) -> AnyPublisher<[Instrument], Never> in
                self.instruments = [Instrument]()
                return InstrumentApi.shared.fetchInstruments(from: Endpoint(index: indexEndpoint, text: search)!)
            }
            .assign(to: \.instruments, on: self)
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
}
