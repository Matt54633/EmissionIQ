//
//  MacModifier.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import Foundation
import SwiftUI

// MacModifier is used to set min/max screen sizes on MacOS
struct MacModifier: ViewModifier {
    func body(content: Content) -> some View {
        if ProcessInfo.processInfo.isiOSAppOnMac {
            content.frame(minWidth: 600, maxWidth: 1400, minHeight: 800, maxHeight: 1000)
        } else {
            content
        }
    }
}

