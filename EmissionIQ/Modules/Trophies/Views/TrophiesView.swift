//
//  TrophiesView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 17/03/2024.
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
                .frame(height: horizontalSizeClass == .compact ? 75 : 90)
                
                if !journeys.isEmpty {
                    
                    GeometryReader { geometry in
                        ScrollView {
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: geometry.size.width > 900 ? 2 : 1), spacing: 15) {
                                
                                ForEach(viewModel.groupAndSortTrophies(trophies: trophies).keys.sorted(), id: \.self) { type in
                                    
                                    VStack(alignment: .leading) {
                                        
                                        GalleryHeaderView(image: viewModel.imageForTrophyType(type), title: type, displayNavIndicator: false, topPadding: 0)
                                        
                                        if let trophiesOfType = viewModel.groupAndSortTrophies(trophies: trophies)[type] {
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
                viewModel.updateTrophies(trophies: trophies, journeys: journeys, readArticles: readArticles, context: context)
            }
            .onChange(of: journeys) {
                viewModel.updateTrophies(trophies: trophies, journeys: journeys, readArticles: readArticles, context: context)
            }
        }
    }
}

#Preview {
    TrophiesView()
}

