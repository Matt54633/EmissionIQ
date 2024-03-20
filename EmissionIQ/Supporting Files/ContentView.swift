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
        Group {
            if onboardingComplete == true {
                NavView()
            } else if viewModel.isTrialPeriod {
                OnboardingStartView()
            } else {
                OnboardingLockedView()
            }
        }
        .onAppear {
            viewModel.calculateIsTrialPeriod()
            
            NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { _ in
                viewModel.calculateIsTrialPeriod()
            }
        }
    }
}

#Preview {
    ContentView()
}
