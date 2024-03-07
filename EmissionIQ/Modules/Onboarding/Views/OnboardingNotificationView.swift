//
//  OnboardingNotificationView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import SwiftUI

// OnboardingNotificationView allows the user to opt in to notification access
struct OnboardingNotificationView: View {
    @StateObject var notificationManager = NotificationManager()
    @AppStorage("onboardingComplete") var onboardingComplete: Bool?
    
    var body: some View {
        VStack {
            
            OnboardingDetailView(image: "app.badge", title: "Notification Access", subTitle: "EmissionIQ sends a daily reminder to add your journeys to keep you on track!", systemImage: true)
            
            Button {
                onboardingComplete = true
            } label: {
                ReusableButtonView(backgroundColour: .lightGrey, text: "No Thanks", textColor: .primary, opacity: 0.25, radius: 15, disabled: nil)
            }
            
            Button {
                notificationManager.requestPermission()
            } label: {
                ReusableButtonView(backgroundColour: .primaryGreen, text: "Allow", textColor: .white, opacity: 1.0, radius: 15, disabled: nil)
            }
            .onChange(of: notificationManager.authorizationStatus) {
                if notificationManager.authorizationStatus == .authorized {
                    onboardingComplete = true
                }
            }
            
        }
        .frame(maxWidth: 700)
        .padding([.horizontal, .bottom])
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OnboardingNotificationView()
}
