//
//  TrophyManager.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation
import SwiftData

// TrophyManager is responsible for inserting trophies into the model context
class TrophyManager: ObservableObject {
    
    // initialise all trophies
    func setTrophies(context: ModelContext) {
        let trophies = [
            Trophy(name: "Journey Explorer", desc: "Completed 1 Journey", goal: "Complete 1 Journey", type: "Journey", rank: "bronze", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Journey Adventurer", desc: "Completed 10 Journeys", goal: "Complete 10 Journeys", type: "Journey", rank: "bronze", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Journey Trailblazer", desc: "Completed 25 Journeys", goal: "Complete 25 Journeys", type: "Journey", rank: "silver", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Journey Master", desc: "Completed 50 Journeys", goal: "Complete 50 Journeys", type: "Journey", rank: "gold", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Journey Champion", desc: "Completed 100 Journeys", goal: "Complete 100 Journeys", type: "Journey", rank: "gold", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "XP Explorer", desc: "Accumulated 1000 XP", goal: "Accumulate 1000 XP", type: "XP", rank: "bronze", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "XP Adventurer", desc: "Accumulated 5000 XP", goal: "Accumulate 5000 XP", type: "XP", rank: "bronze", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "XP Trailblazer", desc: "Accumulated 10000 XP", goal: "Accumulate 10000 XP", type: "XP", rank: "silver", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "XP Master", desc: "Accumulated 25000 XP", goal: "Accumulate 25000 XP", type: "XP", rank: "gold", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "XP Champion", desc: "Accumulated 50000 XP", goal: "Accumulate 50000 XP", type: "XP", rank: "gold", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Distance Explorer", desc: "Travelled 5 Miles", goal: "Travel 5 miles", type: "Distance", rank: "bronze", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Distance Adventurer", desc: "Travelled 50 Miles", goal: "Travel 50 miles", type: "Distance", rank: "bronze", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Distance Trailblazer", desc: "Travelled 100 Miles", goal: "Travel 100 miles", type: "Distance", rank: "silver", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Distance Master", desc: "Travelled 250 Miles", goal: "Travel 250 miles", type: "Distance", rank: "gold", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Distance Champion", desc: "Travelled 500 Miles", goal: "Travel 500 miles", type: "Distance", rank: "gold", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Level Explorer", desc: "Reached Level 1", goal: "Reach Level 1", type: "Level", rank: "bronze", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Level Adventurer", desc: "Reached Level 5", goal: "Reach Level 5", type: "Level", rank: "bronze", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Level Trailblazer", desc: "Reached Level 10", goal: "Reach Level 10", type: "Level", rank: "silver", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Level Master", desc: "Reached Level 25", goal: "Reach Level 25", type: "Level", rank: "gold", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Level Champion", desc: "Reached Level 50", goal: "Reach Level 50", type: "Level", rank: "gold", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Trophy Explorer", desc: "Collected 1 Trophy", goal: "Collect 1 Trophy", type: "Trophy", rank: "bronze", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Trophy Adventurer", desc: "Collected 5 Trophies", goal: "Collect 5 Trophies", type: "Trophy", rank: "bronze", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Trophy Trailblazer", desc: "Collected 10 Trophies", goal: "Collect 10 Trophies", type: "Trophy", rank: "silver", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Trophy Master", desc: "Collected 20 Trophies", goal: "Collect 20 Trophies", type: "Trophy", rank: "gold", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Trophy Champion", desc: "Collected 30 Trophies", goal: "Collect 30 Trophies", type: "Trophy", rank: "gold", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Article Explorer", desc: "Read 1 Article", goal: "Read 1 Article", type: "Article", rank: "bronze", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Article Adventurer", desc: "Read 5 Articles", goal: "Read 5 Articles", type: "Article", rank: "bronze", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Article Trailblazer", desc: "Read 10 Articles", goal: "Read 10 Articles", type: "Article", rank: "silver", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Article Master", desc: "Read 25 Articles", goal: "Read 25 Articles", type: "Article", rank: "gold", isAchieved: false, dateAchieved: Date()),
            Trophy(name: "Article Champion", desc: "Read 50 Articles", goal: "Read 50 Articles", type: "Article", rank: "gold", isAchieved: false, dateAchieved: Date()),
        ]
        
        for trophy in trophies {
            context.insert(trophy)
        }
    }
}
