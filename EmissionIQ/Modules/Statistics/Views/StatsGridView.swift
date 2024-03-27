//
//  StatsGridView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 11/03/2024.
//

import SwiftUI
import SwiftData

// View to group statistics together
struct StatsGridView: View {
    @Query private var journeys: [Journey]
    @Query private var trophies: [Trophy]
    @Query private var readArticles: [ReadArticle]
    @StateObject var privateDataManager = PrivateDataManager.shared
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        VStack {
            
            LazyVGrid(columns: columns) {
                
                StatsItemView(statistic: String(format: "%.1f", journeys.calculateTotalEmissions()), title: "kg CO₂e")
                
                StatsItemView(statistic: String(format: "%.1f", journeys.calculateTotalDistance()), title: "Miles Travelled")
                
                StatsItemView(statistic: String(journeys.count), title: "Journeys")
                
                StatsItemView(statistic: String(journeys.calculateZeroCarbonJourneysCount()), title: "CO₂e Free Journeys")
                
                StatsItemView(statistic: String(trophies.filter { $0.isAchieved }.count), title: "Trophies")
                
                StatsItemView(statistic: String(journeys.calculateMostPopularJourneyMethod()?.capitalized ?? ""), title: "Favourite Transport")
                
                StatsItemView(statistic: String(readArticles.count), title: "Articles Read")
                
                StatsItemView(statistic: String(privateDataManager.userCreationDate?.shortFormattedDate ?? ""), title: "Date Joined")
                
            }
            .onAppear {
                Task {
                    try await _ = privateDataManager.fetchUserCreationDate()
                }
            }
        }
    }
}

#Preview {
    StatsGridView()
}
