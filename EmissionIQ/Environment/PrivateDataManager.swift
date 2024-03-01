//
//  PrivateDataManager.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import CloudKit

// PrivateDataManager is responsible for storing data in a users' private Cloudkit database
// This means data can only be read by a devices linked to the current user

class PrivateDataManager {
    static let shared = PrivateDataManager()
    
    private let userIdRecordType = "User"
    private let userIdKey = "userId"
    private let userCreatedKey = "userCreated"
    private let privateDatabase =  CKContainer(identifier: "iCloud.matt54633.emissionIQ").privateCloudDatabase
    
    private init() {}
    
    // save userID to CloudKit private database - synced across devices
    func saveUserId(userId: String, userCreated: Date, completion: @escaping (Error?) -> Void) {
        let recordID = CKRecord.ID(recordName: userIdRecordType)
        let record = CKRecord(recordType: userIdRecordType, recordID: recordID)
        record[userIdKey] = userId as CKRecordValue
        record[userCreatedKey] = userCreated as CKRecordValue
        
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
    
    // fetch user's ID from CloudKit private database
    func fetchUserId(completion: @escaping ((userId: String, userCreated: Date)?, Error?) -> Void) {
        let recordID = CKRecord.ID(recordName: userIdRecordType)
        privateDatabase.fetch(withRecordID: recordID) { record, error in
            if let userId = record?[self.userIdKey] as? String, let userCreated = record?[self.userCreatedKey] as? Date {
                completion((userId, userCreated), nil)
            } else {
                completion(nil, error)
            }
        }
    }

    // create a user if not existing
    func createUser(completion: @escaping ((userId: String, userCreated: Date)?, Error?) -> Void) {
        fetchUserId { result, error in
            if let error = error, (error as? CKError)?.code == .unknownItem {
                let newUserId = self.generateUserId()
                let currentDate = Date()
                self.saveUserId(userId: newUserId, userCreated: currentDate) { error in
                    if let error = error {
                        completion(nil, error)
                    } else {
                        completion((newUserId, currentDate), nil)
                    }
                }
            } else {
                completion(result, error)
            }
        }
    }


    // create a user ID if not existing
    private func createUserId(completion: @escaping ((userId: String, userCreated: Date)?, Error?) -> Void) {
        let newUserId = self.generateUserId()
        let currentDate = Date()
        self.saveUserId(userId: newUserId, userCreated: currentDate) { error in
            if let error = error {
                completion(nil, error)
            } else {
                completion((newUserId, currentDate), nil)
            }
        }
    }
    
    // fetch the user's creationDate
    func fetchUserCreationDate(completion: @escaping (Date?, Error?) -> Void) {
        let recordID = CKRecord.ID(recordName: userIdRecordType)
        privateDatabase.fetch(withRecordID: recordID) { record, error in
            if let userCreated = record?[self.userCreatedKey] as? Date {
                completion(userCreated, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    // generate a random username
    func generateUserId() -> String {
        let adjectives = ["Brave", "Quick", "Fast", "Firey", "Angry", "Bold", "Calm", "Kind", "Wise"]
        let nouns = ["Lion", "Fox", "Owl", "Tiger", "Bear", "Wolf", "Hawk", "Deer", "Swan", "Goat"]
        return "\(adjectives.randomElement() ?? "Brave")\(nouns.randomElement() ?? "Lion")\(Int.random(in: 1...99))"
    }
}
