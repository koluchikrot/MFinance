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
    case forecast(instrumentId: String)
    
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
            return "filter"
        case .searchedInstruments:
            return "search"
        case .latestNews:
            return "api/news/all"
        case .instrumentNews:
            return "api/news/instrument"
        case .forecast:
            return "forecast"
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
            urlComponents.queryItems = [URLQueryItem(name: "filterName", value: filterName)]
        case .searchedInstruments(let searchText):
            urlComponents.queryItems = [URLQueryItem(name: "searchText", value: searchText)]
        case .instrumentNews(let instrumentId):
            urlComponents.queryItems = [URLQueryItem(name: "instrumentId", value: instrumentId)]
        case .forecast(let instrumentId):
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
        case 7: self = .forecast(instrumentId: text)
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
        let basicToken = defaults.value(forKey: "jsonwebtoken")!
        
        let headers = [
            "Authorization": "Bearer \(basicToken)",
        ]
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        request.allHTTPHeaderFields = headers
        
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map{ response in
                print("\(response.data)")
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
                print("\(response)")
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
                print("\(response)")
                return response.news
            }
            .replaceError(with: [News]())
            .eraseToAnyPublisher()
    }
}
