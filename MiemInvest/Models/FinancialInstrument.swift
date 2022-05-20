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
    var country: String?
    var price: Int?
    var index: Int?
    var attachmentId: String?
    
    var isFavorite: Bool
    
    var image: Image {
        if let fileID = attachmentId {
            return Image(fileID)
        } else {
            return Image("sample_image")
        }
    }
}

struct InstrumentsResponse: Codable {
    var instruments: [Instrument]
}
