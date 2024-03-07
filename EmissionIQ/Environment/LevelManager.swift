//
//  LevelManager.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import CloudKit

// LevelManager is responsible for handling user level and xp operations, syncing the data to the user's CloudKit private database

class LevelManager {
    static let shared = LevelManager()
    
    @Published var isUpdating = false
    
    private let levelRecordType = "Level"
    private let levelKey = "level"
    private let xpKey = "xp"
    private let privateDatabase = CKContainer(identifier: "iCloud.matt54633.emissionIQ").privateCloudDatabase
    private init() {}
    
    // save level and xp to CloudKit private database - synced across devices
    func saveLevelAndXP(level: Int, xp: Int) async throws {
        isUpdating = true
        let recordID = CKRecord.ID(recordName: levelRecordType)
        
        do {
            let record = try await privateDatabase.record(for: recordID)
            
            record[levelKey] = level as CKRecordValue
            record[xpKey] = xp as CKRecordValue
            
            try await privateDatabase.save(record)
        } catch {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to save record: \(error)"])
        }
        
        isUpdating = false
    }
    
    // create a new level and xp record
    func createLevelAndXP() async throws {
        let recordID = CKRecord.ID(recordName: levelRecordType)
        let record = CKRecord(recordType: levelRecordType, recordID: recordID)
        record[levelKey] = 0 as CKRecordValue
        record[xpKey] = 0 as CKRecordValue

        do {
            try await privateDatabase.save(record)
        } catch {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create record: \(error)"])
        }
    }
    
    // fetch user's level and xp from CloudKit private database
    func fetchLevelAndXP() async throws -> (level: Int, xp: Int) {
        let recordID = CKRecord.ID(recordName: levelRecordType)
        do {
            let record = try await privateDatabase.record(for: recordID)
            if let level = record[levelKey] as? Int, let xp = record[xpKey] as? Int {
                return (level, xp)
            } else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch level and XP"])
            }
        } catch {
            // if record doesn't exist, create it
            try await createLevelAndXP()
            return (0, 0)
        }
    }
    
    // add xp to the user
    func addXP(xp: Int) async throws {
        let (currentLevel, currentXP) = try await fetchLevelAndXP()
        let totalXP = currentLevel * 1000 + currentXP + xp
        let newLevel = totalXP / 1000
        let remainingXP = totalXP % 1000
        try await saveLevelAndXP(level: newLevel, xp: remainingXP)
    }
}

