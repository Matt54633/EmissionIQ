//
//  Paragraph.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import Foundation

// Struct to store paragraphs and headers for data sources
struct Paragraph: Decodable, Hashable {
    let header: String
    let text: String
}
