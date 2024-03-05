//
//  Article.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import Foundation

// Struct to store data relating to an Article along with the source of the article
struct Article: Decodable {
    let source: ArticleSource
    let title: String
    let url: String
}
