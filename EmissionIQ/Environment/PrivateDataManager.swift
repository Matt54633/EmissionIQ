//
//  PrivateDataManager.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import CloudKit

// PrivateDataManager is responsible for storing data in a users' private Cloudkit database, this means data can only be read by a devices linked to the current user

class PrivateDataManager {
    static let shared = PrivateDataManager()
    
    private let userIdRecordType = "User"
    private let userIdKey = "userId"
    private let userCreatedKey = "userCreated"
    private let defaultContainer = CKContainer.default()
    private let privateDatabase = CKContainer.default().privateCloudDatabase
    private init() {}
    
    // save userID to CloudKit private database - synced across devices
    func saveUserId(userId: String, userCreated: Date) async throws {
        let recordID = CKRecord.ID(recordName: userIdRecordType)
        let record = CKRecord(recordType: userIdRecordType, recordID: recordID)
        record[userIdKey] = userId as CKRecordValue
        record[userCreatedKey] = userCreated as CKRecordValue
        
        _ = try await privateDatabase.modifyRecords(saving: [record], deleting: [])
    }
    
    // fetch user's ID from CloudKit private database
    func fetchUserId() async throws -> (userId: String, userCreated: Date) {
        let recordID = CKRecord.ID(recordName: userIdRecordType)
        let record = try await privateDatabase.record(for: recordID)
        if let userId = record[userIdKey] as? String, let userCreated = record[userCreatedKey] as? Date {
            return (userId, userCreated)
        } else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch user ID"])
        }
    }
    
    // create a user if not existing
    func createUser() async throws -> (userId: String, userCreated: Date) {
        do {
            let (userId, userCreated) = try await fetchUserId()
            if userId.isEmpty {
                let newUserId = self.generateUserId()
                let currentDate = Date()
                try await saveUserId(userId: newUserId, userCreated: currentDate)
                return (newUserId, currentDate)
            } else {
                return (userId, userCreated)
            }
        } catch {
            let newUserId = self.generateUserId()
            let currentDate = Date()
            try await saveUserId(userId: newUserId, userCreated: currentDate)
            return (newUserId, currentDate)
        }
    }
    
    // fetch the user's creationDate
    func fetchUserCreationDate() async throws -> Date {
        let recordID = CKRecord.ID(recordName: userIdRecordType)
        let record = try await privateDatabase.record(for: recordID)
        if let userCreated = record[userCreatedKey] as? Date {
            return userCreated
        } else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch user creation date"])
        }
    }
    
    // generate a random username
    func generateUserId() -> String {
        let adjectives = ["Brave", "Quick", "Fast", "Firey", "Angry", "Bold", "Calm", "Kind", "Wise"]
        let nouns = ["Lion", "Fox", "Owl", "Tiger", "Bear", "Wolf", "Hawk", "Deer", "Swan", "Goat"]
        return "\(adjectives.randomElement() ?? "Brave")\(nouns.randomElement() ?? "Lion")\(Int.random(in: 1...99))"
    }
}
