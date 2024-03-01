//
//  LevelManager.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import CloudKit

// LevelManager is responsible for handling user level and xp operations, syncing the data to
// the user's CloudKit private database

class LevelManager {
    static let shared = LevelManager()
    
    private let levelRecordType = "Level"
    private let levelKey = "level"
    private let xpKey = "xp"
    private let defaultContainer = CKContainer.default()
    private let privateDatabase = CKContainer.default().privateCloudDatabase
    
    private init() {}
    
    // save level and xp to CloudKit private database - synced across devices
    func saveLevelAndXP(level: Int, xp: Int, completion: @escaping (Error?) -> Void) {
        let recordID = CKRecord.ID(recordName: levelRecordType)
        let record = CKRecord(recordType: levelRecordType, recordID: recordID)
        record[levelKey] = level as CKRecordValue
        record[xpKey] = xp as CKRecordValue
        
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.modifyRecordsResultBlock = { result in
            if case .failure(let error) = result {
                completion(error)
            } else {
                completion(nil)
            }
        }
        
        privateDatabase.add(operation)
    }
    
    // fetch user's level and xp from CloudKit private database
    func fetchLevelAndXP(completion: @escaping ((level: Int, xp: Int)?, Error?) -> Void) {
        let recordID = CKRecord.ID(recordName: levelRecordType)
        privateDatabase.fetch(withRecordID: recordID) { record, error in
            if let level = record?[self.levelKey] as? Int, let xp = record?[self.xpKey] as? Int {
                completion((level, xp), nil)
            } else if let error = error, (error as? CKError)?.code == .unknownItem {
                // if record doesn't exist, create it
                self.saveLevelAndXP(level: 0, xp: 0) { error in
                    if let error = error {
                        completion(nil, error)
                    } else {
                        completion((0, 0), nil)
                    }
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    // add xp to the user
    func addXP(xp: Int, completion: @escaping (Error?) -> Void) {
        fetchLevelAndXP { result, error in
            if let (_, currentXP) = result {
                let newXP = currentXP + xp
                let newLevel = newXP / 1000
                let remainingXP = newXP % 1000
                self.saveLevelAndXP(level: newLevel, xp: remainingXP, completion: completion)
            } else {
                completion(error)
            }
        }
    }
}
