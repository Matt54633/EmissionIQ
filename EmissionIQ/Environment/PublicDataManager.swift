//
//  PublicDataManager.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import CloudKit

// PublicDataManager handles fetching, saving and handling any data that is stored in the CloudKit public database
// This allows leaderboards to read user scores etc.
// Data is not actually 'public', it just means data can be read on all user's devices

class PublicDataManager: ObservableObject {
    static let shared = PublicDataManager()
    
    private let userRecordType = "PublicUser"
    private let publicDatabase = CKContainer(identifier: "iCloud.matt54633.emissionIQ").publicCloudDatabase
    private var currentUserId: String?
    
    private init() {
        fetchCurrentUserId()
    }
    
    // get the user's Id from the private database
    private func fetchCurrentUserId() {
        PrivateDataManager.shared.fetchUserId { result, error in
            if let (userId, _) = result {
                self.currentUserId = userId
            }
        }
    }
    
    // fetch the user's level and xp from the level manager
    func fetchLevelAndXP(completion: @escaping ((Int, Int)?, Error?) -> Void) {
        LevelManager.shared.fetchLevelAndXP { result, error in
            if let (level, xp) = result {
                completion((level, xp), nil)
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
    
    // fetch the user's public record
    func fetchUserRecord(completion: @escaping (CKRecord?, Error?) -> Void) {
        guard let userId = self.currentUserId else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID is not available"]))
            return
        }
        
        let predicate = NSPredicate(format: "userId = %@", userId)
        let query = CKQuery(recordType: self.userRecordType, predicate: predicate)
        
        self.publicDatabase.fetch(withQuery: query, inZoneWith: nil) { result in
            if let record = try? result.get().matchResults.first?.1.get() {
                completion(record, nil)
            } else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch record"]))
            }
        }
    }
    
    // create the user's public record
    func createUserRecord(userId: String, completion: @escaping (CKRecord?, Error?) -> Void) {
        let predicate = NSPredicate(format: "userId == %@", userId)
        let query = CKQuery(recordType: self.userRecordType, predicate: predicate)
        
        publicDatabase.fetch(withQuery: query, inZoneWith: nil, desiredKeys: nil, resultsLimit: 1) { result in
            if let record = try? result.get().matchResults.first?.1.get() {
                completion(record, nil)
            } else {
                let record = CKRecord(recordType: self.userRecordType)
                record["userId"] = userId as CKRecordValue
                self.publicDatabase.save(record) { savedRecord, error in
                    completion(savedRecord, error)
                }
            }
        }
    }
    
    // save attributes to the user's public record
    func saveUserRecord(record: CKRecord, attributes: [String: CKRecordValue], completion: @escaping (Error?) -> Void) {
        guard let userId = self.currentUserId else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID is not available"]))
            return
        }
        
        let recordToSave = record
        recordToSave["userId"] = userId as CKRecordValue
        for (key, value) in attributes {
            recordToSave[key] = value
        }
        self.publicDatabase.save(recordToSave) { _, error in
            completion(error)
        }
    }
    
    // get updated xp and level values, and handle attributes before saving
    func setPublicUserRecord(attributes: [String: CKRecordValue], completion: @escaping (Error?) -> Void) {
        fetchLevelAndXP { result, error in
            if let (level, xp) = result {
                var updatedAttributes = attributes
                let totalXp = level * 1000 + xp
                
                updatedAttributes["level"] = level as CKRecordValue
                updatedAttributes["xp"] = totalXp as CKRecordValue
                
                self.fetchUserRecord { record, error in
                    if let record = record {
                        self.saveUserRecord(record: record, attributes: updatedAttributes, completion: completion)
                    } else if let error = error {
                        completion(error)
                    }
                }
            } else if let error = error {
                completion(error)
            }
        }
    }
    
    // fetch all data for a given attribute
    func fetchAllData(for key: String, completion: @escaping ([(userId: String, value: Int)]?, Error?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: userRecordType, predicate: predicate)
        
        publicDatabase.fetch(withQuery: query, inZoneWith: nil) { result in
            if let fetchResult = try? result.get() {
                let data = fetchResult.matchResults.compactMap { recordTuple -> (userId: String, value: Int)? in
                    if let record = try? recordTuple.1.get(), let userId = record["userId"] as? String, let value = record[key] as? Int {
                        return (userId, value)
                    } else {
                        return nil
                    }
                }
                completion(data, nil)
            } else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data"]))
            }
        }
    }
}
