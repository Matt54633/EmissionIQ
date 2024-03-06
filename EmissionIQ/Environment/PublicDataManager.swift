//
//  PublicDataManager.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import CloudKit

/* PublicDataManager handles fetching, saving and handling any data that is stored in the CloudKit public database
This allows leaderboards to read user scores etc.
Data is not actually 'public', it just means data can be read on all users devices */

class PublicDataManager: ObservableObject {
    static let shared = PublicDataManager()
    
    private let userRecordType = "PublicUser"
    private let defaultContainer = CKContainer.default()
    private let publicDatabase = CKContainer.default().publicCloudDatabase
    private var currentUserId: String?
    
    private init() {
        Task {
            do {
                try await fetchCurrentUserId()
            } catch {
                print("Error fetching User ID \(error)")
            }
        }
    }
    
    // fetch the user's Id from the private database
    private func fetchCurrentUserId() async throws {
        let (userId, _) = try await PrivateDataManager.shared.fetchUserId()
        self.currentUserId = userId
    }
    
    // fetch the user's level and xp from the level manager
    func fetchLevelAndXP() async throws -> (Int, Int) {
        let (level, xp) = try await LevelManager.shared.fetchLevelAndXP()
        return (level, xp)
    }
    
    // fetch the user's public record
    func fetchUserRecord() async throws -> CKRecord {
        guard let userId = self.currentUserId else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID is not available"])
        }
        
        let predicate = NSPredicate(format: "userId = %@", userId)
        let query = CKQuery(recordType: self.userRecordType, predicate: predicate)
        
        let (matchResults, _) = try await self.publicDatabase.records(matching: query)
        guard let record = try matchResults.first?.1.get() else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch record"])
        }
        return record
    }
    
    // create the user's public record
    func createUserRecord(userId: String) async throws -> CKRecord {
        let predicate = NSPredicate(format: "userId == %@", userId)
        let query = CKQuery(recordType: self.userRecordType, predicate: predicate)
        
        let (matchResults, _) = try await publicDatabase.records(matching: query)
        if let record = try? matchResults.first?.1.get() {
            return record
        } else {
            let record = CKRecord(recordType: self.userRecordType)
            record["userId"] = userId as CKRecordValue
            let savedRecord = try await self.publicDatabase.save(record)
            return savedRecord
        }
    }
    
    // save attributes to the user's public record
    func saveUserRecord(record: CKRecord, attributes: [String: CKRecordValue]) async throws {
        guard let userId = self.currentUserId else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID is not available"])
        }
        
        let recordToSave = record
        recordToSave["userId"] = userId as CKRecordValue
        for (key, value) in attributes {
            recordToSave[key] = value
        }
        try await self.publicDatabase.save(recordToSave)
    }
    
    func setPublicUserRecord(attributes: [String: CKRecordValue]) async throws {
        let (level, xp) = try await fetchLevelAndXP()
        var updatedAttributes = attributes
        let totalXp = level * 1000 + xp
        
        updatedAttributes["level"] = level as CKRecordValue
        updatedAttributes["xp"] = totalXp as CKRecordValue
        
        let record = try await fetchUserRecord()
        try await saveUserRecord(record: record, attributes: updatedAttributes)
    }
    
    // fetch all data for a given attribute
    func fetchAllData(for key: String) async throws -> [(userId: String, value: Int)] {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: userRecordType, predicate: predicate)
        
        let (matchResults, _) = try await publicDatabase.records(matching: query)
        let data = matchResults.compactMap { matchResult -> (userId: String, value: Int)? in
            switch matchResult.1 {
            case .success(let record):
                if let userId = record["userId"] as? String, let value = record[key] as? Int {
                    return (userId, value)
                } else {
                    return nil
                }
            case .failure(_):
                return nil
            }
        }
        return data
    }
}
