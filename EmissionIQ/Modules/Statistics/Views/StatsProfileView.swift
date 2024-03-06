//
//  StatsProfileView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// StatsProfileView displays information about the user along with some basic stats
struct StatsProfileView: View {
    @ObservedObject var viewModel: StatsViewModel
    private let tip = StatsOverviewTip()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Spacer()
            
            HStack {
                
                Text(viewModel.userId ?? "")
                    .font(.system(size: 45, weight: .bold))
                    .foregroundStyle(.primaryGreen)
                
                Spacer()
                
                LevelIndicatorView(displayOuter: true, frameWidth: 40, progressWidth: 5, fontSize: 18)
                
            }
            .padding(.bottom, 10)
            .popoverTip(tip, arrowEdge: .top)
            
            LevelXpView()
            
            StatsGridView(viewModel: viewModel)
            
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 50, trailing: 15 ))
        .onAppear {
            Task {
                await viewModel.fetchUserId()
            }
        }
    }
}

#Preview {
    StatsProfileView(viewModel: StatsViewModel())
}
