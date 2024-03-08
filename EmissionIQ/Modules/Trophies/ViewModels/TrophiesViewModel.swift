//
//  TrophiesViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation
import SwiftData
import CloudKit

class TrophiesViewModel: ObservableObject {
    @Published private var level: Int = 0
    @Published private var xp: Int = 0
    
    private let trophyManager = TrophyManager()
    private let levelManager = LevelManager.shared
    
    // group and then sort the trophies into the correct order
    func groupAndSortTrophies(trophies: [Trophy]) -> [String: [Trophy]] {
        let groupedTrophies = Dictionary(grouping: trophies, by: { $0.type })
        var sortedTrophies: [String: [Trophy]] = [:]
        
        for type in groupedTrophies.keys {
            if let trophiesOfType = groupedTrophies[type] {
                let order = ["Explorer", "Adventurer", "Trailblazer", "Master", "Champion"]
                sortedTrophies[type] = trophiesOfType.sorted {
                    var index1 = Int.max
                    var index2 = Int.max
                    for (idx, word) in order.enumerated() {
                        if $0.name.contains(word) { index1 = idx }
                        if $1.name.contains(word) { index2 = idx }
                    }
                    return index1 < index2
                }
            }
        }
        
        return sortedTrophies
    }
    
    // set the trophy type section image
    func imageForTrophyType(_ type: String) -> String {
        switch type {
        case "Distance":
            return "point.topleft.down.to.point.bottomright.curvepath"
        case "Journey":
            return "map.fill"
        case "Level":
            return "l1.circle.fill"
        case "Trophy":
            return "trophy.fill"
        case "XP":
            return "star.square.on.square.fill"
        case "Article":
            return "newspaper.fill"
        default:
            return "default_image"
        }
    }
    
    // on first app launch, initialise trophuies and save to container
    func initialiseTrophies(trophies: [Trophy], context: ModelContext) {
        if trophies.isEmpty {
            trophyManager.setTrophies(context: context)
        }
    }
    
    // update all trophies
    func updateAllTrophies(journeys: [Journey], trophies: [Trophy], readArticles: [ReadArticle]) {
        updateJourneyTrophies(journeys: journeys, trophies: trophies)
        updateArticleTrophies(readArticles: readArticles, trophies: trophies)
        updateDistanceTrophies(journeys: journeys, trophies: trophies)
        updateTrophyTrophies(trophies: trophies)
        updateLevelTrophies(trophies: trophies)
        updateXpTrophies(trophies: trophies)
    }
    
    // fetch level and xp
    func fetchLevelAndXp(completion: @escaping () -> Void) {
        Task {
            let (fetchedLevel, fetchedXp) = try await LevelManager.shared.fetchLevelAndXP()
            
            DispatchQueue.main.async {
                self.level = fetchedLevel
                self.xp = fetchedXp
                completion()
            }
        }
    }
    
    // set the user's trophies to their public record
    func setUserTrophies(trophies: [Trophy]) async throws {
        let numberOfTrophiesAchieved = trophies.filter { $0.isAchieved }.count
        
        let attributes: [String: CKRecordValue] = [
            "trophies": numberOfTrophiesAchieved as CKRecordValue,
        ]
        
        do {
            try await PublicDataManager.shared.setPublicUserRecord(attributes: attributes)
        } catch {
            print("Error setting trophy values: \(error)")
            throw error
        }
    }
    
    // update journey trophies based on number of journeys a user has
    private func updateJourneyTrophies(journeys: [Journey], trophies: [Trophy]) {
        let trophyNames = ["Journey Explorer", "Journey Adventurer", "Journey Trailblazer", "Journey Master", "Journey Champion"]
        let journeyCounts = [1, 10, 25, 50, 100]
        
        for (index, name) in trophyNames.enumerated() {
            if let trophyIndex = trophies.firstIndex(where: { $0.name == name }) {
                // only update the trophy not achieved
                if !trophies[trophyIndex].isAchieved {
                    trophies[trophyIndex].isAchieved = journeys.count >= journeyCounts[index]
                    if trophies[trophyIndex].isAchieved {
                        trophies[trophyIndex].dateAchieved = Date()
                    }
                }
            }
        }
    }
    
    private func updateArticleTrophies(readArticles: [ReadArticle], trophies: [Trophy]) {
        let trophyNames = ["Article Explorer", "Article Adventurer", "Article Trailblazer", "Article Master", "Article Champion"]
        let articleCounts = [1, 5, 10, 25, 50]
        
        for (index, name) in trophyNames.enumerated() {
            if let trophyIndex = trophies.firstIndex(where: { $0.name == name }) {
                // only update the trophy not achieved
                if !trophies[trophyIndex].isAchieved {
                    trophies[trophyIndex].isAchieved = readArticles.count >= articleCounts[index]
                    if trophies[trophyIndex].isAchieved {
                        trophies[trophyIndex].dateAchieved = Date()
                    }
                }
            }
        }
    }
    
    // update xp trophies based on xp a user has
    private func updateXpTrophies(trophies: [Trophy]) {
        if let xp = levelManager.xp, let level = levelManager.level {
            let totalXp = xp + level * 1000
            
            let trophyNames = ["XP Explorer", "XP Adventurer", "XP Trailblazer", "XP Master", "XP Master"]
            let xpCounts = [1000, 5000, 10000, 25000, 50000]
            
            for (index, name) in trophyNames.enumerated() {
                if let trophy = trophies.first(where: { $0.name == name }), !trophy.isAchieved {
                    trophy.isAchieved = totalXp >= xpCounts[index]
                    if trophy.isAchieved {
                        trophy.dateAchieved = Date()
                    }
                }
            }
        }
    }
    
    // update distance trophies based on miles travelled
    private func updateDistanceTrophies(journeys: [Journey], trophies: [Trophy]) {
        let totalDistance = journeys.reduce(0) { $0 + $1.distance }
        
        let trophyNames = ["Distance Explorer", "Distance Adventurer", "Distance Trailblazer", "Distance Master", "Distance Champion"]
        let distanceCounts = [5, 50, 100, 250, 500]
        
        for (index, name) in trophyNames.enumerated() {
            if let trophyIndex = trophies.firstIndex(where: { $0.name == name }) {
                // only update the trophy not achieved
                if !trophies[trophyIndex].isAchieved {
                    trophies[trophyIndex].isAchieved = Int(totalDistance) >= distanceCounts[index]
                    if trophies[trophyIndex].isAchieved {
                        trophies[trophyIndex].dateAchieved = Date()
                    }
                }
            }
        }
    }
    
    // update trophy trophies based on trophies achieved
    private func updateTrophyTrophies(trophies: [Trophy]) {
        let totalTrophies = trophies.filter { $0.isAchieved }.count
        
        let trophyNames = ["Trophy Explorer", "Trophy Adventurer", "Trophy Trailblazer", "Trophy Master", "Trophy Champion"]
        let trophyCounts = [1, 5, 10, 20, 30]
        
        for (index, name) in trophyNames.enumerated() {
            if let trophyIndex = trophies.firstIndex(where: { $0.name == name }) {
                // update the trophy based on the total trophies
                let isAchieved = totalTrophies >= trophyCounts[index]
                if trophies[trophyIndex].isAchieved != isAchieved {
                    trophies[trophyIndex].isAchieved = isAchieved
                    trophies[trophyIndex].dateAchieved = Date()
                }
            }
        }
    }
    
    // update level trophies based on user level
    private func updateLevelTrophies(trophies: [Trophy]) {
        if let level = levelManager.level {
            let trophyNames = ["Level Explorer", "Level Adventurer", "Level Trailblazer", "Level Master", "Level Champion"]
            let levelCounts = [1, 5, 10, 25, 50]
            
            for (index, name) in trophyNames.enumerated() {
                if let trophy = trophies.first(where: { $0.name == name }), !trophy.isAchieved {
                    trophy.isAchieved = level >= levelCounts[index]
                    if trophy.isAchieved {
                        trophy.dateAchieved = Date()
                    }
                }
            }
        }
    }
    
    // remove duplicate trophies that can occur when syncing iCloud onto new devices
    func removeDuplicateTrophies(trophies: [Trophy], context: ModelContext) {
        var trophyDict = [String: Trophy]()
        for trophy in trophies {
            if let _ = trophyDict[trophy.name] {
                context.delete(trophy)
            } else {
                trophyDict[trophy.name] = trophy
            }
        }
    }
    
    // wrapper function to be used by other views when they require updating trophies
    func updateTrophies(trophies: [Trophy], journeys: [Journey], readArticles: [ReadArticle], context: ModelContext) {
        if !journeys.isEmpty {
            if trophies.isEmpty {
                self.initialiseTrophies(trophies: trophies, context: context)
            }
            self.removeDuplicateTrophies(trophies: trophies, context: context)
            self.updateAllTrophies(journeys: journeys, trophies: trophies, readArticles: readArticles)
            
            Task {
                try await self.setUserTrophies(trophies: trophies)
            }
        }
    }
}
