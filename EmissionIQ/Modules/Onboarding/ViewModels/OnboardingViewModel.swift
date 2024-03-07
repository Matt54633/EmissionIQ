//
//  OnboardingViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import Foundation
import CloudKit

class OnboardingViewModel: ObservableObject {
    @Published var userNotSignedIn: Bool = false
    @Published var displaySheet: Bool = false
    
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
