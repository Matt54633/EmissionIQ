//
//  NavView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// Tab controller for page control, selectedTab can be passed into child views to manually set the active tab
struct NavView: View {
    @Query(sort: \Trophy.dateAchieved, order: .forward) private var trophies: [Trophy]
    @StateObject var privateDataManager = PrivateDataManager.shared
    @StateObject var levelManager = LevelManager.shared
    @State private var displayTrophyAchievedView: Bool = false
    @State private var newTrophy: Trophy?
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            JourneysView()
                .tabItem {
                    Label("Journeys", systemImage: "map.fill")
                }
                .tag(1)
            
            TrophiesView()
                .tabItem {
                    Label("Trophies", systemImage: "trophy.fill")
                }
                .tag(2)
            
            LeaderboardsView()
                .tabItem {
                    Label("Leaderboards", systemImage: "chart.bar.fill")
                }
                .tag(3)
            
            LearningView()
                .tabItem {
                    Label("Learning", systemImage: "graduationcap.fill")
                }
                .tag(4)
            
        }
        .tint(.primaryGreen)
        .overlay(alignment: .top) {
            if let newTrophy = newTrophy {
                
                TrophyAchievedView(displayTrophyAchievedView: $displayTrophyAchievedView, trophy: newTrophy)
                    .onTapGesture {
                        selectedTab = 2
                    }
                
            }
        }
        .onChange(of: trophies.filter({ $0.isAchieved }).count) { oldCount, newCount in
            if newCount > oldCount {
                
                newTrophy = trophies.sorted { $0.dateAchieved < $1.dateAchieved }.last
                displayTrophyAchievedView = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    displayTrophyAchievedView = false
                }
                
            }
        }
        .onAppear {
            Task {
                try await _ = privateDataManager.fetchUserId()
                try await _ = privateDataManager.fetchUserCreationDate()
                try await _ = levelManager.fetchLevelAndXP()
            }
        }
    }
}

#Preview {
    NavView()
}

