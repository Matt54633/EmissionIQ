//
//  CarbonOutputViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation
import CloudKit

class CarbonOutputViewModel: ObservableObject {
    
    // set the users number of journeys, active days, and read articles in their public data record
    func setUserAttributes(journeys: [Journey], trophies: [Trophy], readArticles: [ReadArticle]) async {
        let totalDistance = journeys.reduce(0) { $0 + $1.distance }.rounded(.down)
        let totalImpact = journeys.reduce(0) { $0 + $1.carbonProduced }.rounded(.down)
        
        do {
            let fetchedDate = try await PrivateDataManager.shared.fetchUserCreationDate()
            let activeDays = self.calculateActiveDays(from: fetchedDate)
            let attributes = self.createAttributes(journeys: journeys, trophies: trophies, readArticles: readArticles, totalDistance: Double(totalDistance), totalImpact: Double(totalImpact), activeDays: activeDays)
            
            try await self.setPublicUserRecord(attributes: attributes)
        } catch {
            print("Error fetching user creation date: \(error)")
        }
    }
    
    // calculate how many days account has been active for
    private func calculateActiveDays(from fetchedDate: Date) -> Int {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.day], from: fetchedDate, to: now)
        return (components.day ?? 0) + 1
    }
    
    // create attributes for public record
    private func createAttributes(journeys: [Journey], trophies: [Trophy], readArticles: [ReadArticle], totalDistance: Double, totalImpact: Double, activeDays: Int) -> [String: CKRecordValue] {
        return [
            "journeys": journeys.count as CKRecordValue,
            "trophies": trophies.filter { $0.isAchieved }.count as CKRecordValue,
            "distance": totalDistance as CKRecordValue,
            "impact": totalImpact as CKRecordValue,
            "daysActive": activeDays as CKRecordValue,
            "articles": readArticles.count as CKRecordValue
        ]
    }
    
    // set the public record
    private func setPublicUserRecord(attributes: [String: CKRecordValue]) async throws {
        try await PublicDataManager.shared.setPublicUserRecord(attributes: attributes)
    }
}
