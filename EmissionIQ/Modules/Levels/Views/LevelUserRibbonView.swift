//
//  LevelUserRibbonView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// LevelUserRibbonView displays the user's ID in a ribbon
struct LevelUserRibbonView: View {
    @ObservedObject var viewModel: StatsViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    
                    Ribbon()
                        .fill(.primaryGreen)
                        .frame(height: 31)
                    
                    Capsule()
                        .fill(.primaryGreen)
                        .stroke(Color(.systemBackground), lineWidth: 6)
                        .frame(width: geometry.size.width * 0.82, height: 50)
                    
                }
                
                Text(viewModel.userId ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    LevelUserRibbonView(viewModel: StatsViewModel())
}
