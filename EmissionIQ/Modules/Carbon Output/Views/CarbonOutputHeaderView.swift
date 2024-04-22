//
//  CarbonOutputHeaderView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 07/03/2024.
//

import SwiftUI
import SwiftData

// Header to be displayed on the home page which displays the users' carbon output
struct CarbonOutputHeaderView: View {
    @Query private var journeys: [Journey]
    @Query private var trophies: [Trophy]
    @Query private var readArticles: [ReadArticle]
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject private var viewModel = CarbonOutputViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            WavyRectangle(waveCount: horizontalSizeClass == .compact ? 7 : 17)
                .fill(.primaryGreen)
                .ignoresSafeArea(edges: .top)
            
            VStack(alignment: .leading) {
                Spacer()
                
                CarbonOutputValueView()
                    .onAppear {
                        Task {
                            await viewModel.publishActiveDays()
                        }
                    }
            }
            .overlay(alignment: .topTrailing) {
                
                NavigationLink {
                    LevelView()
                } label: {
                    LevelIndicatorView(displayOuter: false, frameWidth: 32, progressWidth: 4, fontSize: 17)
                }
                .padding(.top, horizontalSizeClass == .compact ? 5 : 15)
                
            }
            .modifier(ConditionalPadding())
            .padding(.horizontal, 15)
            
        }
    }
}

#Preview {
    CarbonOutputHeaderView()
}
