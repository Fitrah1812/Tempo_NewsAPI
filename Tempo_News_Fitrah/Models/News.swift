//
//  News.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 15/08/23.
//

import Foundation


struct News: Identifiable {
    let id = UUID()
    let creator: String
    let title: String
    let link: String
    let content: String
    let categories: [String]
    let isoDate: String
    let image: String
    
}
