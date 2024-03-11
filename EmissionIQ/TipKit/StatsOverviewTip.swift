//
//  StatsOverviewTip.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 07/03/2024.
//

import Foundation
import TipKit

// Tip to explain the stats pages
struct StatsOverviewTip: Tip {
    
    var title: Text {
        Text("Swipe for more")
    }
    
    var message: Text? {
        Text("Swipe to see detailed breakdowns of more stats!")
    }
    
    var options: [Option] {
        MaxDisplayCount(1)
    }
    
}
