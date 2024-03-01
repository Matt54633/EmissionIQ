//
//  Trivia.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import Foundation

// Struct to store a trivia item
struct Trivia: Codable, Equatable {
    let question: String
    let answer: String
}
