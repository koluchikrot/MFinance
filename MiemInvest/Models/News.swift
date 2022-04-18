//
//  News.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import Foundation

struct News: Codable, Identifiable {
    var id: Int
    var header: String?
    var publishedDate: Date?
    var source: String?
    var fullText: String?
    var shortText: String?
    var sentimental: Float
}
