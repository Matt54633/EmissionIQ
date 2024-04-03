//
//  OnboardingViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 11/03/2024.
//

import Foundation
import CloudKit

class OnboardingViewModel: ObservableObject {
    @Published var userNotSignedIn: Bool = false
    @Published var userCreated: Bool = false
    @Published var displaySheet: Bool = false
    @Published var iCloudTitle: String = ""
    @Published var iCloudError: String = ""
    @Published var daysUntilAprilFirst: Int = 0
    @Published var isTrialPeriod: Bool = false
    
    // calculate the number of days until the trial begins
    func calculateDaysUntilAprilFirst() {
        let currentDate = Date()
        let currentYear = Calendar.current.component(.year, from: currentDate)
        let aprilFirstThisYear = Calendar.current.date(from: DateComponents(year: currentYear, month: 4, day: 1))!
        
        daysUntilAprilFirst = max(0, Calendar.current.numberOfDaysBetween(currentDate, and: aprilFirstThisYear))
    }
    
    // calculate whether current date is within trial period to restrict application access
    func calculateIsTrialPeriod() {
        let currentDate = Date()
        let currentYear = Calendar.current.component(.year, from: currentDate)
        
        let startPeriod = Calendar.current.date(from: DateComponents(year: currentYear, month: 4, day: 1))!
        
        let daysUntilStart = Calendar.current.numberOfDaysBetween(currentDate, and: startPeriod)
        
        isTrialPeriod = daysUntilStart <= 0
    }
    
    init() {
        checkICloudStatus()
    }
    
    // check if the device is signed into iCloud
    func checkICloudStatus() {
        CKContainer.default().accountStatus { (accountStatus, error) in
            DispatchQueue.main.async {
                self.displaySheet = accountStatus == .noAccount
                self.userNotSignedIn = accountStatus == .noAccount
                self.iCloudTitle = "Sign into iCloud"
                self.iCloudError = "EmissionIQ requires iCloud to sync your emissions across your devices!"
                
                if accountStatus == .available {
                    let privateDatabase = CKContainer(identifier: "iCloud.matt54633.emissionIQ").privateCloudDatabase
                    let record = CKRecord(recordType: "CheckStorage")
                    
                    privateDatabase.save(record) { (record, error) in
                        if let error = error as? CKError {
                            if error.code == .quotaExceeded {
                                DispatchQueue.main.async {
                                    self.displaySheet = true
                                    self.iCloudTitle = "iCloud Storage Full"
                                    self.iCloudError = "EmissionIQ requires iCloud. Free up space by deleting unused data!"
                                }
                            }
                        } else {
                            if let record = record {
                                privateDatabase.delete(withRecordID: record.recordID) { (recordID, error) in
                                    if let error = error {
                                        print("Failed to delete test record: \(error)")
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    // create user if required
    func createUser() async throws {
        let result = try await PrivateDataManager.shared.createUser()
        let userId = result.userId
        _ = try await PublicDataManager.shared.createUserRecord(userId: userId)
        
        DispatchQueue.main.async {
            self.userCreated = true
        }
    }
}
