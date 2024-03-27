//
//  Articles.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 03/03/2024.
//

import Foundation

// Struct to store all articles returned from NewsAPI
struct Articles: Decodable {
    let articles: [Article]
}
