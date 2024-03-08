//
//  StatsView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// View to display all stats data, from galleries to graphs
struct StatsView: View {
    @Query private var journeys: [Journey]
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: StatsViewModel
    
    var body: some View {
        NavigationStack {
            
            VStack {
                if !journeys.isEmpty {
                    
                    TabView {
                        
                        StatsProfileView(statsViewModel: viewModel)
                        
                        StatsTabView(
                            title: String(journeys.count),
                            subTitle: "Journeys",
                            chartType: "Journeys",
                            axisLabel: nil,
                            journeysByMethod: viewModel.journeysByMethod,
                            dataPoints: viewModel.journeysOverTime
                        )
                        
                        StatsTabView(
                            title: String(format: "%.1f" , journeys.calculateTotalDistance()),
                            subTitle: "Miles",
                            chartType: "Miles",
                            axisLabel: "mi",
                            journeysByMethod: viewModel.journeysByMethod,
                            dataPoints: viewModel.distanceOverTime
                        )
                        
                        StatsTabView(
                            title: String(format: "%.1f" , journeys.calculateTotalEmissions()),
                            subTitle: "kg CO₂e",
                            chartType: "kg CO₂e",
                            axisLabel: "kg",
                            journeysByMethod: viewModel.journeysByMethod,
                            dataPoints: viewModel.carbonEmittedOverTime
                        )
                    }
                    .navigationTitle("Stats")
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(.page(backgroundDisplayMode: colorScheme == .dark ?  .never : .always))
                    .modifier(ConditionalPadding())
                    
                } else {
                    JourneyMessageView()
                }
                
            }
            .onAppear {
                viewModel.calculateStatsOverTime(journeys: journeys)
                viewModel.calculateJourneysByMethod(journeys: journeys)
                
                Task {
                    await viewModel.fetchUserCreationDate()
                }
            }
        }
    }
}


#Preview {
    StatsView(viewModel: StatsViewModel())
}
