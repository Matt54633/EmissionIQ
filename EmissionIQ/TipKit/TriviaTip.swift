//
//  TriviaTip.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import Foundation
import TipKit

// Tip to highlight trivia  features
struct TriviaTip: Tip {
    
    var title: Text {
        Text("Peel to Reveal")
    }
    
    var message: Text? {
        Text("Peel the daily trivia back to reveal the answer!")
    }
    
    var options: [Option] {
        MaxDisplayCount(1)
    }
    
}
