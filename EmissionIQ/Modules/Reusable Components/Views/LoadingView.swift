//
//  LoadingView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 23/02/2024.
//

import SwiftUI

// LoadingView is used to display a progress wheel
struct LoadingView: View {
    var body: some View {
        VStack {
            
            Spacer()
            
            ProgressView()
                .padding()
                .scaleEffect(1.5, anchor: .center)
                .tint(.primaryGreen)
            
            Spacer()
            
        }
    }
}

#Preview {
    LoadingView()
}
