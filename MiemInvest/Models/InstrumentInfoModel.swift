//
//  InstrumentInfoModel.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 24.05.2022.
//

import Foundation

struct InstrumentInfo: Codable, Identifiable {
    var id: String
    var name: String
    var ticker: String?
    var price: String?
    var index: Int?
    var attachmentId: String?
    var description: String?
    var country: String?
    var predictions: [Prediction]
    
    var isFavorite: Bool?
}

struct Prediction: Codable, Identifiable {
    let id = UUID()
    var type: String
    var certainty: String
    var prediction: String
    var date: String
}
