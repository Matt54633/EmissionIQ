//
//  RoundedSheet.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 23/02/2024.
//

import Foundation
import SwiftUI

// View modifier to style sheets
struct RoundedSheet: ViewModifier {
    let radius: CGFloat
    let height: PresentationDetent
    
    func body(content: Content) -> some View {
        content
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(radius)
            .presentationDetents([height])
    }
}
