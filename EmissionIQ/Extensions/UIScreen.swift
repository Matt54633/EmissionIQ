//
//  UIScreen.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import Foundation
import SwiftUI

// Extension to enable type safe screen
extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
