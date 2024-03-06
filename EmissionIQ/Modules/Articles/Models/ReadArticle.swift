//
//  ReadArticle.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation
import SwiftUI
import SwiftData

// ReadArticle Model to store articles read by users for leaderboards etc.
@Model
final class ReadArticle: Identifiable {
    var id: String = ""
    var articleTitle: String = ""
    var dateRead: Date = Date()
    
    init(articleTitle: String, dateRead: Date) {
        self.id = UUID().uuidString
        self.articleTitle = articleTitle
        self.dateRead = dateRead
    }
}
