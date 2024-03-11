//
//  Trophy.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 17/03/2024.
//

import Foundation
import SwiftUI
import SwiftData

// Trophy Model to store available and achieved trophies
@Model
final class Trophy: Identifiable {
    var id: String = ""
    var name: String = ""
    var desc: String = ""
    var goal: String = ""
    var type: String = ""
    var rank: String = ""
    var isAchieved: Bool = false
    var dateAchieved: Date = Date()
    
    init(name: String, desc: String, goal: String, type: String, rank: String, isAchieved: Bool, dateAchieved: Date) {
        self.id = UUID().uuidString
        self.name = name
        self.desc = desc
        self.goal = goal
        self.type = type
        self.rank = rank
        self.isAchieved = isAchieved
        self.dateAchieved = dateAchieved
    }
}

