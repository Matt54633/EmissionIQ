//
//  UIWindow.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import Foundation
import SwiftUI

// Extension to enable type safe screen dimensions
extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}
