//
//  OnboardingSignInView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import SwiftUI

// OnboardingSignInView prevents the user progressing through onboarding until they sign into iCloud
struct OnboardingSignInView: View {
    var body: some View {
        VStack {
            
            OnboardingDetailView(image: "icloud.circle.fill", title: "Sign into iCloud", subTitle: "EmissionIQ uses iCloud to sync your emissions across your devices!", systemImage: true)
            
            Button(action: {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }) {
                ReusableButtonView(backgroundColour: .primaryGreen, text: "Open Settings", textColor: .white, opacity: 1.0, radius: 15, disabled: nil)
            }
            
        }
        .padding([.horizontal, .bottom])
        .modifier(RoundedSheet(radius: 25, height: .medium))
    }
}

#Preview {
    OnboardingSignInView()
}
