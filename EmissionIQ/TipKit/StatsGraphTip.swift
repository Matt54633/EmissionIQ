//
//  StatsGraphTip.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 07/03/2024.
//

import Foundation
import TipKit

// Tip to reveal interactive graph
struct StatsGraphTip: Tip {
    
    var title: Text {
        Text("Get the breakdown")
    }
    
    var message: Text? {
        Text("Tap and hold a data point to see more!")
    }
    
    var options: [Option] {
        MaxDisplayCount(1)
    }
    
}
