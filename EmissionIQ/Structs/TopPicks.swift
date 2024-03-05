//
//  TopPicks.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import Foundation

// Struct to store all articles from the topPicks JSON file
struct TopPicks: Decodable {
    let articles: [Article]
}
