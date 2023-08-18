//
//  TempoNews.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 13/08/23.
//

import Foundation

struct DataApi: Codable {
    let message: String
    let total: Int
    let data : [DataClass]
}

struct DataClass: Codable {
    let creator: String
    let title: String
    let link: String
    let content: String
    let categories: [String]
    let isoDate: String
    let image: String
}
