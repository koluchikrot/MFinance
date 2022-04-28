//
//  ModelData.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import Foundation

var instrumentsResponse: InstrumentsResponse = load("companies.json")
var instruments: [Instrument] = instrumentsResponse.companies

var newsResponse: NewsResponse = load("news.json")
var news: [News] = newsResponse.news

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
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

