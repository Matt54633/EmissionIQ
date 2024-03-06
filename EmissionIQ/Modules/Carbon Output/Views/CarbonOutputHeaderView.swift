//
//  CarbonOutputHeaderView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// Header to be displayed on the home page which displays the users' carbon output
struct CarbonOutputHeaderView: View {
    @Query private var journeys: [Journey]
    @Query private var trophies: [Trophy]
    @Query private var readArticles: [ReadArticle]
    @StateObject private var viewModel = CarbonOutputViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            WavyRectangle()
                .fill(.primaryGreen)
            
            VStack(alignment: .leading) {
                Spacer()
                
                CarbonOutputValueView()
                    .onAppear {
                        Task {
                            await viewModel.setUserAttributes(journeys: journeys, trophies: trophies, readArticles: readArticles)
                        }
                    }
                    .onChange(of: journeys) {
                        Task {
                            await viewModel.setUserAttributes(journeys: journeys, trophies: trophies, readArticles: readArticles)
                        }
                    }
                
            }
            .overlay(alignment: .topTrailing) {
                
                NavigationLink {
                    LevelView()
                } label: {
                    LevelIndicatorView(displayOuter: false, frameWidth: 32, progressWidth: 4, fontSize: 17)
                }
                .padding(.top, UIScreen.current?.bounds.height ?? 600 > 700 ? 55 : 30)
                
            }
            .modifier(ConditionalPadding())
            .padding(.horizontal, 15)
        }
        .ignoresSafeArea(.all)
        
    }
}

#Preview {
    CarbonOutputHeaderView()
}
