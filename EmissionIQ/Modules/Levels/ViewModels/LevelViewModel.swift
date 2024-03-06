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
    @Published var level: Int?
    @Published var xp: Int?
    @Published var levelUpLevel: Int = 0
    @Published var displaySheet: Bool = false
    
    private var currentLevel: Int?
    var timer: Timer? = nil
    
    init() {
        fetchLevelAndXp()
    }
    
    // fetch Level and XP from the LevelManager
    func fetchLevelAndXp() {
        Task {
            do {
                let (level, xp) = try await LevelManager.shared.fetchLevelAndXP()
                DispatchQueue.main.async {
                    self.level = level
                    self.xp = xp
                    
                    if let level = self.level {
                        if self.currentLevel == nil {
                            self.currentLevel = level
                        } else if level > self.currentLevel! {
                            self.currentLevel = level
                            self.displaySheet = true
                        }
                    }
                }
            } catch {
                print("Failed to fetch Level/XP Data", error)
            }
        }
    }
    
    // start the level up timer to change the displayed level
    func startTimer(level: Int) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / Double(level), repeats: true) { [weak self] _ in
            withAnimation {
                self?.levelUpLevel += 1
            }
        }
    }
    
    // stop the level up timer
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

