//
//  FilterModel.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 23.05.2022.
//

import Foundation

struct Filter: Codable, Identifiable {
    let id = UUID()
    var key: String
    var value: String
}

struct FilterResponse: Codable {
    var filters: [Filter]
}
