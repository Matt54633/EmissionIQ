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
                if accountStatus == .noAccount {
                    self.userNotSignedIn = true
                    self.displaySheet = true
                } else {
                    self.userNotSignedIn = false
                    self.displaySheet = false
                }
            }
        }
    }
    
    // create user if required
    func createUser() {        
        PrivateDataManager.shared.createUser { result, error in
            if let userId = result?.userId {
                PublicDataManager.shared.createUserRecord(userId: userId) { record, error in }
            }
        }
    }
}
