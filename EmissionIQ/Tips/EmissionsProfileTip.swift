//
//  EmissionsProfileTip.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import Foundation
import TipKit

// Tip to highlight transport type features on emisissions profile
struct EmissionsProfileTip: Tip {
    
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
