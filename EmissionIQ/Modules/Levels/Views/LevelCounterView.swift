//
//  LevelCounterView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// LevelCounterView displays the user's level counting up to the new value
struct LevelCounterView: View {
    @ObservedObject var viewModel: LevelViewModel
    let level: Int
    
    var body: some View {
        
        Text("\(viewModel.levelUpLevel)")
            .font(.system(size: 130))
            .contentTransition(.numericText())
            .onAppear {
                viewModel.startCountdown(level: level)
            }
        
    }
}

#Preview {
    LevelCounterView(viewModel: LevelViewModel(), level: 10)
}
