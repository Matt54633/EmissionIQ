//
//  ConditionalContainerRelativeFrame.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/02/2024.
//

import SwiftUI

// ViewModifier to conditionally apply relative frame modifier
struct ConditionalContainerRelativeFrame: ViewModifier {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var fixedWidth: CGFloat

    func body(content: Content) -> some View {
        if horizontalSizeClass == .compact {
            content.containerRelativeFrame(.horizontal)
        } else {
            if fixedWidth != 0 {
                content.frame(width: fixedWidth)
            }
        }
    }
}
