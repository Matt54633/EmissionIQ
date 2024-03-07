//
//  LevelIndicatorView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData
import Combine

// View to display the users' level and progress for that level
struct LevelIndicatorView: View {
    @Query private var journeys: [Journey]
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = LevelViewModel()
    @State private var cancellable: AnyCancellable?
    
    let displayOuter: Bool
    let frameWidth: Double
    let progressWidth: Double
    let fontSize: Int
    
    var body: some View {
        ZStack {
            
            if !displayOuter {
                Circle()
                    .fill(Color(.systemBackground))
                    .frame(maxWidth: frameWidth + 10)
            }
            
            if let level = viewModel.level, let xp = viewModel.xp {
                let levelProgress = Double(xp % 1000) / 1000
                
                if displayOuter {
                    LevelProgressView(progress: 1.0, color: colorScheme == .dark ? Color.white.opacity(0.4) : .lightGrey.opacity(0.5), strokeWidth: progressWidth, frameWidth: frameWidth)
                }
                
                LevelProgressView(progress: levelProgress, color: .primaryGreen, strokeWidth: progressWidth, frameWidth: frameWidth)
                
                LevelTextView(level: level, fontSize: fontSize, color: colorScheme == .dark ? .white : .black)
                
            } else {
                if displayOuter {
                    LevelProgressView(progress: 1.0, color: colorScheme == .dark ? Color.white.opacity(0.5) : Color(.gray).opacity(0.5), strokeWidth: progressWidth, frameWidth: frameWidth)
                }
                
                LevelTextView(level: 0, fontSize: fontSize, color: colorScheme == .dark ? .white : .black)
                
            }
        }
        .sheet(isPresented: $viewModel.displaySheet) {
            if let level = viewModel.level {
                LevelUpView(level: level)
            }
        }
        .onAppear {
            viewModel.fetchLevelAndXp()
        }
        .onChange(of: journeys) {
            cancellable = Timer.publish(every: 0.2, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    if !LevelManager.shared.isUpdating {
                        viewModel.fetchLevelAndXp()
                        cancellable?.cancel()
                    }
                }
        }
    }
}
