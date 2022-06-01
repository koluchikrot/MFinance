//
//  InstrumentResponses.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 04.05.2022.
//

import Foundation
import Combine

enum Endpoint {
    // instrument lists
    case favoriteInstruments
    case topInstruments
    case userTop
    case filteredInstruments(_ filterName: String)
    case searchedInstruments(_ searchText: String)
    
    // news lists
    case latestNews
    case instrumentNews(instrumentId: String)
    
    // instrument information
    case instrumentInfo(instrumentId: String)
    
    // filters
    case filters
    
    var baseUrl: URL {
         URL(string: "http://192.168.0.17:8443/")!
    }
    
    func path() -> String {
        switch self {
        case .favoriteInstruments:
            return "api/user/favorites"
        case .topInstruments:
            return "api/instrument/top"
        case .userTop:
            return "api/user/top"
        case .filteredInstruments:
            return "api/instrument/search/filtered"
        case .searchedInstruments:
            return "api/instrument/search/text"
        case .latestNews:
            return "api/news/all"
        case .instrumentNews:
            return "api/news/instrument"
        case .instrumentInfo(let instrumentId):
            return "api/instrument/\(instrumentId)/info"
        case .filters:
            return "api/instrument/filters"
        }
    }
    
    var absoluteUrl: URL? {
        let queryURL = baseUrl.appendingPathComponent(self.path())
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else {
            return nil
        }
        switch self {
        case .filteredInstruments(let filterName):
            urlComponents.queryItems = [URLQueryItem(name: "filter", value: filterName)]
        case .searchedInstruments(let searchText):
            urlComponents.queryItems = [URLQueryItem(name: "searchTerms", value: searchText)]
        case .instrumentNews(let instrumentId):
            urlComponents.queryItems = [URLQueryItem(name: "instrumentId", value: instrumentId)]
        default:
            break
        }
        return urlComponents.url
    }
    
    init? (index: Int, text: String = "RU") {
        switch index {
        case 0: self = .favoriteInstruments
        case 1: self = .topInstruments
        case 2: self = .userTop
        case 3: self = .filteredInstruments(text)
        case 4: self = .searchedInstruments(text)
        case 5: self = .latestNews
        case 6: self = .instrumentNews(instrumentId: text)
        case 7: self = .instrumentInfo(instrumentId: text)
        case 8: self = .filters
        default: return nil
        }
    }
}

class InstrumentApi {
    public static let shared = InstrumentApi()
    
    var decoder: JSONDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd.MM.yyyy"

        let decoder = JSONDecoder()

        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }
    
    func fetch<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        let defaults = UserDefaults.standard
        guard let basicToken = defaults.value(forKey: "jsonwebtoken") else {
            return Empty(completeImmediately: false).eraseToAnyPublisher()
        }
//        let basicToken = defaults.value(forKey: "jsonwebtoken")!
        
        let headers = [
            "Authorization": "Bearer \(basicToken)",
        ]
        
//        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        request.allHTTPHeaderFields = headers
        
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map{ response in
//                print("\(response.data)")
                return response.data }
            .decode(type: T.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
        return publisher
    }
    
    func fetchInstruments(from endpoint: Endpoint) -> AnyPublisher<[Instrument], Never> {
        guard let url = endpoint.absoluteUrl else {
            return Just([Instrument]()).eraseToAnyPublisher()
        }
        return fetch(url)
            .map { (response: InstrumentsResponse) -> [Instrument] in
//                print("\(response)")
                return response.instruments
            }
            .replaceError(with: [Instrument]())
            .eraseToAnyPublisher()
    }
    
    func fetchNews(from endpoint: Endpoint) -> AnyPublisher<[News], Never> {
        guard let url = endpoint.absoluteUrl else {
            return Just([News]()).eraseToAnyPublisher()
        }
        return fetch(url)
            .map { (response: NewsResponse) -> [News] in
//                print("\(response)")
                return response.news
            }
            .replaceError(with: [News]())
            .eraseToAnyPublisher()
    }
    
    func fetchFilters(from endpoint: Endpoint) -> AnyPublisher<[Filter], Never> {
        guard let url = endpoint.absoluteUrl else {
            return Just([Filter]()).eraseToAnyPublisher()
        }
        return fetch(url)
            .map { (response: FilterResponse) -> [Filter] in
//                print("\(response)")
                return response.filters
            }
            .replaceError(with: [Filter]())
            .eraseToAnyPublisher()
    }
    
    func fetchInstrumentInfo(from endpoint: Endpoint) -> AnyPublisher<InstrumentInfo?, Never> {
        guard let url = endpoint.absoluteUrl else {
            print("wrong url")
            return Just(nil).eraseToAnyPublisher()
        }
        return fetch(url)
//            .map { (response: FilterResponse) -> [Filter] in
//                print("\(response)")
//                return response.filters
//            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
