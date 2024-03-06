//
//  OnboardingStartView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import SwiftUI

// OnboardingStartView displays the welcome screen to the app
struct OnboardingStartView: View {
    @StateObject var viewModel = OnboardingViewModel()
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                OnboardingDetailView(image: "App Logo", title: "Welcome!", subTitle: "Your EmissionIQ journey starts here. Are you ready to begin?", systemImage: false)
                
                if viewModel.userNotSignedIn == true {
                    ReusableButtonView(backgroundColour: .primaryGreen, text: "Start your journey", textColor: .white, opacity: 1.0, radius: 15, disabled: true)
                        .onTapGesture {
                            viewModel.displaySheet = true
                        }
                } else {
                    NavigationLink {
                        OnboardingLocationView()
                    } label: {
                        ReusableButtonView(backgroundColour: .primaryGreen, text: "Start your journey", textColor: .white, opacity: 1.0, radius: 15, disabled: false)
                    }
                }
                
            }
            .padding([.horizontal, .bottom])
            
        }
        .sheet(isPresented: $viewModel.displaySheet) {
            OnboardingSignInView()
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { _ in
                viewModel.checkICloudSignInStatus()
            }
            
            Task {
                try await viewModel.createUser()
            }
        }
        .navigationBarBackButtonHidden()
        .tint(.primaryGreen)
    }
}

#Preview {
    OnboardingStartView()
}
