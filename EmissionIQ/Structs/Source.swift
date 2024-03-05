//
//  Source.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import Foundation
import SwiftUI

// Struct to store data sources
struct Source: Decodable {
    let name: String
    let image: String
    let details: Details
}
