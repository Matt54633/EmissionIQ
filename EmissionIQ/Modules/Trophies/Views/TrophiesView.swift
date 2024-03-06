//
//  TrophiesView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// View to display all available Trophies
struct TrophiesView: View {
    @Query private var journeys: [Journey]
    @Query(sort: \Trophy.dateAchieved, order: .forward) private var trophies: [Trophy]
    @Query private var readArticles: [ReadArticle]
    @Environment(\.modelContext) private var context
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @ObservedObject var viewModel = TrophiesViewModel()
    @State private var displayTrophyAchievedView: Bool = false
    @State private var newTrophy: Trophy?
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                
                PageHeaderView(pageTitle: "Trophies") {
                    NavigationLink {
                        LevelView()
                    } label: {
                        LevelIndicatorView(displayOuter: false, frameWidth: 32, progressWidth: 4, fontSize: 17)
                    }
                }
                .frame(height: horizontalSizeClass == .compact ? 75 : 110)
                
                if !journeys.isEmpty {
                    
                    GeometryReader { geometry in
                        ScrollView {
                            
                            let groupedAndSortedTrophies = viewModel.groupAndSortTrophies(trophies: trophies)
                            let sortedKeys = groupedAndSortedTrophies.keys.sorted()
                            let columns = Array(repeating: GridItem(.flexible()), count: geometry.size.width > 800 ? 2 : 1)
                            
                            LazyVGrid(columns: columns) {
                                ForEach(sortedKeys, id: \.self) { type in
                                    
                                    VStack(alignment: .leading) {
                                        
                                        GalleryHeaderView(image: viewModel.imageForTrophyType(type), title: type, displayNavIndicator: false, topPadding: 0)
                                        
                                        if let trophiesOfType = groupedAndSortedTrophies[type] {
                                            ForEach(trophiesOfType, id: \.self) { trophy in
                                                TrophyListItemView(trophy: trophy)
                                            }
                                        }
                                        
                                    }
                                    
                                }
                            }
                            .padding(.bottom, 5)
                        }
                        .padding(.top, horizontalSizeClass == .compact ? 15 : 30)
                        .modifier(ConditionalPadding())
                        
                    }
                    
                } else {
                    JourneyMessageView()
                }
            }
            .tint(.primary)
            .onAppear {
                if !journeys.isEmpty {
                    viewModel.initialiseTrophies(trophies: trophies, context: context)
                    viewModel.removeDuplicateTrophies(trophies: trophies, context: context)
                    viewModel.updateAllTrophies(journeys: journeys, trophies: trophies, readArticles: readArticles)
                    Task {
                        await viewModel.fetchLevelAndXp()
                        try await viewModel.setUserTrophies(trophies: trophies)
                    }
                    
                }
            }
            .onChange(of: journeys) {
                Task {
                    await viewModel.fetchLevelAndXp()
                    try await viewModel.setUserTrophies(trophies: trophies)
                }
                viewModel.updateAllTrophies(journeys: journeys, trophies: trophies, readArticles: readArticles)
                
            }
        }
    }
}

#Preview {
    TrophiesView()
}

