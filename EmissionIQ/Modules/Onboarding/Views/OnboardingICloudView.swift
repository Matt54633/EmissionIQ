//
//  OnboardingICloudView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 10/03/2024.
//

import SwiftUI

// OnboardingICloudView prevents the user progressing through onboarding until they sign into iCloud or if their iCloud storage is full
struct OnboardingICloudView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            
            OnboardingDetailView(image: "icloud.circle.fill", title: "\(viewModel.iCloudTitle)", subTitle: "\(viewModel.iCloudError)", systemImage: true)
            
            Button(action: {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }) {
                ReusableButtonView(backgroundColour: .primaryGreen, text: "Open Settings", textColor: .white, opacity: 1.0, radius: 15, disabled: nil)
            }
            
        }
        .frame(maxWidth: 700)
        .padding()
        .modifier(RoundedSheet(radius: 25, height: .medium))
    }
}

#Preview {
    OnboardingICloudView(viewModel: OnboardingViewModel())
}
