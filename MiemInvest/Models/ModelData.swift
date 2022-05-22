//
//  ModelData.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import Foundation
import Combine

//var instrumentsResponse: InstrumentsResponse = load("companies.json")

final class ModelData: ObservableObject {
//        @Published var instruments: [Instrument] = instrumentsResponse.companies
    
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
    
    private var cancellableSet: Set<AnyCancellable> = []
}

//var newsResponse: NewsResponse = load("news.json")
//var news: [News] = newsResponse.news

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd.MM.yyyy"

        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

