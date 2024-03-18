//
//  OnboardingLockedView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 10/03/2024.
//

import SwiftUI

// View to display the number of days until the trial starts
struct OnboardingLockedView: View {
    @StateObject var viewModel = OnboardingViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 25) {
            
            Image("App Logo")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25))
            
            VStack {
                
                Image(systemName: "lock.fill")
                    .font(.system(size: 50))
                    .padding(.bottom, 5)
                
                Text("EmissionIQ")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primaryGreen)
                
                Text("Unlocks in ^[\(viewModel.calculateDaysUntilAprilFirst()) \("day")!](inflect: true)")
                    .font(.title2)
                    .fontWeight(.semibold)
                
            }
            .frame(maxWidth: 380)
            .padding(EdgeInsets(top: 25, leading: 15, bottom: 25, trailing: 15))
            .background(RoundedRectangle(cornerRadius: 25).fill(colorScheme == .dark ? .quaternary : .quinary))
            
        }
        .frame(maxWidth: 380)
        .padding(.horizontal)
    }
}

#Preview {
    OnboardingLockedView()
}
