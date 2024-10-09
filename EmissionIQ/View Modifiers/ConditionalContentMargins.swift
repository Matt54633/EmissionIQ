//
//  ConditionalContentMargins.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/02/2024.
//

import SwiftUI

// Conditionally apply content margins for larger screens
struct ConditionalContentMargins: ViewModifier {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    func body(content: Content) -> some View {
        if horizontalSizeClass == .regular {
            return content.contentMargins(.horizontal, 70, for: .scrollContent)
        } else {
            return content.contentMargins(.horizontal, 15, for: .scrollContent)
        }
        
        
    }
}
