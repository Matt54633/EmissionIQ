//
//  TransportTip.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import TipKit

// Tip to highlight transport type features
struct TransportTip: Tip {
    
    var title: Text {
        Text("Transport Types")
    }
    
    var message: Text? {
        Text("Tap each transport type to see CO₂e produced in kg!")
    }
    
    var options: [Option] {
        MaxDisplayCount(1)
    }
    
}
