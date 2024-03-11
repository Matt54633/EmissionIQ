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
    @Published var displaySheet: Bool = false
    
    // calculate the number of days until the trial begins
    var daysUntilAprilFirst: Int {
        let currentDate = Date()
        let currentYear = Calendar.current.component(.year, from: currentDate)
        let aprilFirstThisYear = Calendar.current.date(from: DateComponents(year: currentYear, month: 3, day: 11))!
        
        return max(0, Calendar.current.numberOfDaysBetween(currentDate, and: aprilFirstThisYear))
    }
    
    // calculate whether current date is within trial period to restrict application access
    var isTrialPeriod: Bool {
        let currentDate = Date()
        let currentYear = Calendar.current.component(.year, from: currentDate)
        
        let startPeriod = Calendar.current.date(from: DateComponents(year: currentYear, month: 3, day: 11))!
        
        let daysUntilStart = Calendar.current.numberOfDaysBetween(currentDate, and: startPeriod)
        
        return daysUntilStart <= 0
    }
    
    init() {
        checkICloudSignInStatus()
    }
    
    // check if the device is signed into iCloud
    func checkICloudSignInStatus() {
        CKContainer.default().accountStatus { (accountStatus, error) in
            DispatchQueue.main.async {
                self.displaySheet = accountStatus == .noAccount
                self.userNotSignedIn = accountStatus == .noAccount
            }
        }
    }
    
    // create user if required
    func createUser() async throws {
        let result = try await PrivateDataManager.shared.createUser()
        let userId = result.userId
        _ = try await PublicDataManager.shared.createUserRecord(userId: userId)
    }
}
