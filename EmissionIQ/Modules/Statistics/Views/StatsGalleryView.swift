//
//  StatsGalleryView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// View to display a preview of stats, linking to the main stats gallery
struct StatsGalleryView: View {
    @Query private var journeys: [Journey]
    @Query private var trophies: [Trophy]
    @Query private var readArticles: [ReadArticle]
    @StateObject private var viewModel = StatsViewModel()
    
    var body: some View {
        NavigationLink {
            StatsView(viewModel: viewModel)
        } label: {
            VStack(alignment: .center) {
                
                GalleryHeaderView(image: "chart.bar.xaxis.ascending", title: "Stats", displayNavIndicator: true, topPadding: 15)
                
                HStack {
                    
                    StatsItemView(statistic: String(format: journeys.calculateTotalDistance() < 1000 ? "%.1f" : "%.0f", journeys.calculateTotalDistance()), title: "Miles")
                    
                    StatsItemView(statistic: String(journeys.count), title: "Journeys")
                    
                    StatsItemView(statistic: String(trophies.filter { $0.isAchieved }.count), title: "Trophies")
                    
                    StatsItemView(statistic: String(readArticles.count), title: "Articles")
                    
                }
                .padding(EdgeInsets(top: 2.5, leading: 15, bottom: 0, trailing: 15))
                
            }
            .onAppear {
                Task {
                    await viewModel.fetchUserId()
                    await viewModel.fetchUserCreationDate()
                }
            }
        }
        .tint(.primary)
    }
}

#Preview {
    StatsGalleryView()
}
