//
//  ContentView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 02/02/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = OnboardingViewModel()
    @AppStorage("onboardingComplete") var onboardingComplete: Bool?
    
    var body: some View {
        if onboardingComplete == true {
            NavView()
        } else if viewModel.isTrialPeriod {
            OnboardingStartView()
        } else {
            OnboardingLockedView()
        }
    }
}

#Preview {
    ContentView()
}
