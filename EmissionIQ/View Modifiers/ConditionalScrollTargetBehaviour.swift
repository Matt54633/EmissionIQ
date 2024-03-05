//
//  ConditionalScrollTargetBehaviour.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import Foundation
import SwiftUI

// Conditionally apply scroll target behaviour based on screen size
struct ConditionalScrollTargetBehavior: ViewModifier {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let behavior: ViewAlignedScrollTargetBehavior
    
    func body(content: Content) -> some View {
        if horizontalSizeClass == .compact {
            content
                .scrollTargetBehavior(behavior)
        }
    }
}

