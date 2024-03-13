//
//  OnboardingLocationView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 10/03/2024.
//

import SwiftUI

// OnboardingLocationView allows the user to opt in to location access
struct OnboardingLocationView: View {
    @State private var readyToNavigate: Bool = false
    var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            
            OnboardingDetailView(image: "location.circle.fill", title: "Location Access", subTitle: "Grant access to see localised search results when adding a journey.", systemImage: true)
            
            NavigationLink {
                OnboardingNotificationView()
            } label: {
                ReusableButtonView(backgroundColour: .lightGrey, text: "No Thanks", textColor: .primary, opacity: 0.25, radius: 15, disabled: nil)
            }
            
            Button {
                locationManager.requestLocationPermission()
            } label: {
                ReusableButtonView(backgroundColour: .primaryGreen, text: "Allow", textColor: .white, opacity: 1.0, radius: 15, disabled: nil)
                    .navigationDestination(isPresented: $readyToNavigate) {
                        OnboardingNotificationView()
                    }
            }
            .onAppear {
                locationManager.onAuthorizationStatusChanged = { newStatus in
                    if newStatus == .authorizedWhenInUse || newStatus == .authorizedAlways {
                        readyToNavigate = true
                    }
                }
            }
            
        }
        .frame(maxWidth: 700)
        .padding([.horizontal, .bottom])
        .navigationBarBackButtonHidden()
        
    }
}

#Preview {
    OnboardingLocationView()
}
