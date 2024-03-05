//
//  Details.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import Foundation

// Struct to store details and links about a data source
struct Details: Decodable {
    let paragraphs: [Paragraph]
    let links: [SourceLink]
}
