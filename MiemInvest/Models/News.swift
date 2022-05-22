//
//  News.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import Foundation
import SwiftUI

struct News: Codable, Identifiable {
    var id: String
    var header: String
    var publishedDate: Date?
    var source: String
    var fullText: String
    var link: String
    var sentiment: String
    var instruments: [Instrument]
}

struct NewsResponse: Codable {
    var news: [News]
}
