//
//  ConditionalPadding.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/02/2024.
//

import SwiftUI

// Conditionally apply padding for larger screens
struct ConditionalPadding: ViewModifier {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    func body(content: Content) -> some View {
        if horizontalSizeClass == .regular {
            return content.padding(.horizontal, 70)
        } else {
            // compact horizontal size class
            return content.padding(.horizontal, 0)
        }
    }
}
