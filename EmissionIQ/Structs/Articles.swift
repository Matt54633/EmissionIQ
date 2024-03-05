//
//  Articles.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import Foundation

// Struct to store all articles returned from NewsAPI
struct Articles: Decodable {
    let articles: [Article]
}
