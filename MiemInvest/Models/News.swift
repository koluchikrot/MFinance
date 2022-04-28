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
    var fileID: String?
    var instrumentsId: [String]
    
    var image: Image {
        if let fileID = fileID {
            return Image(fileID)
        } else {
            return Image("sample_image")
        }
    }
}

struct NewsResponse: Codable {
    var news: [News]
}
