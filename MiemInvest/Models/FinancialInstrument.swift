//
//  FinancialInstrument.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 18.04.2022.
//

import Foundation
import SwiftUI

struct Instrument: Codable, Identifiable {
    var id: String
    var name: String
    var ticker: String?
    var price: Int?
    var index: Int?
    var fileID: String?
    
    var isFavorite: Bool
    
    var image: Image {
        if let fileID = fileID {
            return Image(fileID)
        } else {
            return Image("sample_image")
        }
    }
}

struct InstrumentsResponse: Codable {
    var userId: String
    var companies: [Instrument]
}
