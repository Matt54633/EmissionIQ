//
//  StatsProfileView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// StatsProfileView displays information about the user along with some basic stats
struct StatsProfileView: View {
    @StateObject var levelViewModel = LevelViewModel()
    @ObservedObject var statsViewModel: StatsViewModel
    private let tip = StatsOverviewTip()
    
    var body: some View {
    
        VStack(alignment: .leading) {
            
            Spacer()
            
            HStack {
                
                Text(statsViewModel.userId ?? "")
                    .font(.system(size: 45, weight: .bold))
                    .foregroundStyle(.primaryGreen)
                
                Spacer()
                
                LevelIndicatorView(displayOuter: true, frameWidth: 40, progressWidth: 5, fontSize: 18)
                
            }
            .padding(.bottom, 5)
            .popoverTip(tip, arrowEdge: .top)
            
            LevelXpView(viewModel: levelViewModel)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            
            StatsGridView(viewModel: statsViewModel)
            
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 50, trailing: 15 ))
        .onAppear {
            Task {
                await statsViewModel.fetchUserId()
            }
        }
    }
}

#Preview {
    StatsProfileView(statsViewModel: StatsViewModel())
}
