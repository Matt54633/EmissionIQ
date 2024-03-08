//
//  LevelViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation
import CloudKit
import SwiftUI

class LevelViewModel: ObservableObject {
    static let shared = LevelViewModel()
    
    @Published var levelUpLevel: Int = 0
    @Published var countdownStopped: Bool = false
    
    // start the level up countdown to change the displayed level
    func startCountdown(level: Int) {
        levelUpLevel = 0
        countdownStopped = false
        for i in 1...level {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) / Double(level)) {
                self.levelUpLevel = i
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.countdownStopped = true
        }
    }
    
    func setUserAttributes(level: Int, xp: Int) async {
        let attributes: [String: CKRecordValue] = [
            "level": level as CKRecordValue,
            "xp": xp as CKRecordValue,
        ]
        
        do {
            try await PublicDataManager.shared.setPublicUserRecord(attributes: attributes)
        } catch {
            print("Error setting user level values: \(error)")
        }
    }
}

