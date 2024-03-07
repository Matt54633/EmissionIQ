//
//  ContentView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 30/01/2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboardingComplete") var onboardingComplete: Bool?
    
    var body: some View {
        if onboardingComplete == true || ProcessInfo.processInfo.isiOSAppOnMac {
            NavView()
        } else {
            OnboardingStartView()
        }
    }
}

#Preview {
    ContentView()
}
