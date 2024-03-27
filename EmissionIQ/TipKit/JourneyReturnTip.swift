//
//  JourneyReturnTip.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import Foundation
import TipKit

// Tip to highlight return journey features
struct JourneyReturnTip: Tip {
    
    var title: Text {
        Text("Make it a return")
    }
    
    var message: Text? {
        Text("Tap the arrow indicator to switch between single and return journeys!")
    }
    
    var options: [Option] {
        MaxDisplayCount(1)
    }
    
}

