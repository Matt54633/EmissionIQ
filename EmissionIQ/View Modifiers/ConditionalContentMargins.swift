//
//  ConditionalContentMargins.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/02/2024.
//

import SwiftUI

// Conditionally apply padding for larger screens
struct ConditionalContentMargins: ViewModifier {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    func body(content: Content) -> some View {
        if horizontalSizeClass == .regular {
            return content.contentMargins(.horizontal, 80, for: .scrollContent)
        } else {
            return content.contentMargins(.horizontal, 20, for: .scrollContent)
        }
    }
}
