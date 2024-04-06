//
//  LeaderboardViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 26/03/2024.
//

import Foundation
import SwiftUI

class LeaderboardViewModel: ObservableObject {
    static let shared = LeaderboardViewModel()
    
    @Published var leaderboardData: [String: [(userId: String, value: Int)]] = [:]
    @Published var positionData: [(userId: String, value: Int)]?
    @Published var userId: String?
    @Published var userPositions: [String: String] = [:]
    @Published var leaderboardTypes: [String] = ["journeys", "impact", "level", "xp", "trophies", "distance", "articles", "daysActive"]
    
    private var publicDataManager = PublicDataManager.shared
    private var privateDataManager = PrivateDataManager.shared
    
    init() {
        Task {
            try await userIdFetch()
        }
    }
    
    // fetch the current user ID to match a leaderboard item
    func userIdFetch() async throws {
        let fetchedUser = try await privateDataManager.fetchUserId()
        DispatchQueue.main.async {
            self.userId = fetchedUser.userId
        }
    }
    
    // fetch data for the leaderboard type
    func fetchData(for leaderboardType: String) async throws {
        let fetchedData = try await publicDataManager.fetchAllData(for: leaderboardType)
        DispatchQueue.main.async {
            self.leaderboardData[leaderboardType] = fetchedData
        }
    }
    
    // fetch data for all leaderboard types
    func fetchAllData() async throws {
        for leaderboardType in leaderboardTypes {
            try await fetchData(for: leaderboardType)
        }
    }
    
    // fetch all leaderboard data and find a user's position
    func fetchDataAndCalculatePositions() async throws {
        for leaderboardType in leaderboardTypes {
            let fetchedData = try await publicDataManager.fetchAllData(for: leaderboardType)
            DispatchQueue.main.async {
                self.leaderboardData[leaderboardType] = fetchedData
                
                // calculate a user's position for a specific leaderboard type
                if let userId = self.userId {
                    let sortedData = Array(fetchedData.sorted { self.setLeaderboardOrder(leaderboardType: leaderboardType) ? $0.value > $1.value : $0.value < $1.value }.enumerated())
                    for (index, item) in sortedData.enumerated() {
                        if item.element.userId == userId {
                            let position = index
                            self.userPositions[leaderboardType] = self.ordinalNumberString(from: position)
                        }
                    }
                }
            }
        }
    }
    
    // fetch leaderboard data and find a user's position
    func fetchDataAndCalculatePosition(for leaderboardType: String) async throws {
        let fetchedData = try await publicDataManager.fetchAllData(for: leaderboardType)
        DispatchQueue.main.async {
            self.positionData = fetchedData
            
            if let userId = self.userId {
                let sortedData = Array(fetchedData.sorted { self.setLeaderboardOrder(leaderboardType: leaderboardType) ? $0.value > $1.value : $0.value < $1.value }.enumerated())
                for (index, item) in sortedData.enumerated() {
                    if item.element.userId == userId {
                        let position = index
                        self.userPositions[leaderboardType] = self.ordinalNumberString(from: position)
                    }
                }
            }
            
        }
    }
    
    // set the order of leaderboard display - if false = ascending otherwise = descending
    func setLeaderboardOrder(leaderboardType: String) -> Bool {
        switch leaderboardType {
        case "impact":
            return false
        default:
            return true
        }
    }
    
    // set the colour of a leaderboard position indicator
    func colorForPosition(_ position: Int) -> Color {
        switch position {
        case 0:
            return .gold
        case 1:
            return .silver
        case 2:
            return .bronze
        default:
            return .primary
        }
    }
    
    // set height of podium view item
    func heightMultiplier(index: Int) -> CGFloat {
        switch index {
        case 0:
            return 165
        case 1:
            return 140
        case 2:
            return 115
        default:
            return 115
        }
    }
    
    // set the description for a leaderboard based on it's type
    func setLeaderboardImage(leaderboardType: String) -> String {
        switch leaderboardType {
        case "journeys":
            return "map"
        case "level":
            return "l1.circle"
        case "xp":
            return "star.square.on.square"
        case "trophies":
            return "trophy"
        case "distance":
            return "point.bottomleft.forward.to.point.topright.scurvepath"
        case "impact":
            return "carbon.dioxide.cloud"
        case "articles":
            return "newspaper"
        case "daysActive":
            return "calendar"
        default:
            return "chart.bar"
        }
    }
    
    // set the unit of a leaderboard to provide context when required
    func setLeaderboardUnit(leaderboardType: String) -> String {
        switch leaderboardType {
        case "impact":
            return "kg"
        case "distance":
            return "mi"
        case "daysActive":
            return " Days"
        default:
            return ""
        }
    }
    
    // set ordinal index value to format 3 -> 3rd
    func ordinalNumberString(from number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(from: NSNumber(value: number + 1)) ?? ""
    }
    
    // display a motivational message on the leaderboard to encourage users
    func motivationalMessage(for position: String) -> String {
        switch position {
        case "1st":
            return "Fantastic! You're leading the pack!"
        case "2nd", "3rd":
            return "Great work! Keep it up!"
        case "4th", "5th", "6th", "7th", "8th", "9th", "10th":
            return "You're in the top 10, keep pushing!"
        default:
            return "Keep working towards your progress!"
        }
    }
    
    // display information text to explain info about a leaderboard
    func setInfoText(leaderboardType: String) -> String {
        switch leaderboardType {
        case "journeys":
            return "Total number of journeys"
        case "level":
            return "User level achieved"
        case "xp":
            return "Total XP gained"
        case "trophies":
            return "Total number of trophies"
        case "distance":
            return "Total miles travelled"
        case "impact":
            return "Total kg CO₂e, in descending order"
        case "articles":
            return "Total number of articles read"
        case "daysActive":
            return "Total number of days active"
        default:
            return "Information text"
        }
    }
}

