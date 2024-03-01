//
//  SourceLink.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import Foundation

// Struct to store a link and header for data source links
struct SourceLink: Decodable, Hashable {
    let header: String
    let url: String
}
