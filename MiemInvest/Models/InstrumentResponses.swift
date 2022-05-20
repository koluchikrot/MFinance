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
    case filteredInstruments(_ filterName: String)
    case searchedInstruments(_ searchText: String)
    
    // news lists
    case latestNews
    case instrumentNews(_ instrumentId: String)
    
    // instrument information
    case forecast(_ instrumentId: String)
    
    var baseUrl: URL {
         URL(string: "http://192.168.0.17:8443/")!
    }
    
    func path() -> String {
        switch self {
        case .favoriteInstruments:
            return "user/favorites"
        case .topInstruments:
            return "user/top"
        case .filteredInstruments:
            return "filter"
        case .searchedInstruments:
            return "search"
        case .latestNews, .instrumentNews:
            return "news"
        case .forecast(let instrumentId):
            return "forecast?instrumentId=\(instrumentId)"
        }
    }
    
    var absoluteUrl: URL? {
        let queryURL = baseUrl.appendingPathComponent(self.path())
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else {
            return nil
        }
        switch self {
        case .filteredInstruments (let filterName):
            urlComponents.queryItems = [URLQueryItem(name: "filterName", value: filterName)]
        case .searchedInstruments(let searchText):
            urlComponents.queryItems = [URLQueryItem(name: "searchText", value: searchText)]
        case .instrumentNews(let instrumentId):
            urlComponents.queryItems = [URLQueryItem(name: "instrumentId", value: instrumentId)]
        default:
            return queryURL
        }
        return urlComponents.url
    }
    
    init? (index: Int, text: String = "RU") {
        switch index {
        case 0: self = .favoriteInstruments
        case 1: self = .topInstruments
        case 2: self = .filteredInstruments(text)
        case 3: self = .searchedInstruments(text)
        case 4: self = .latestNews
        case 5: self = .instrumentNews(text)
        case 6: self = .forecast(text)
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
        let basicToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrb2x1Y2hpa3JvdCIsImV4cCI6MTY1MzA4OTA2NCwiaWF0IjoxNjUzMDQ1ODY0fQ.3Z4UKrUcpRNCj1jpl6MCId2KuSFL15VwGjGLWVurug44CRcJF9GhRxLFQZymD4d11B6pOrVh1ygdJmERCd7_Jg"
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
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        print("\(publisher)")
        
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
}
