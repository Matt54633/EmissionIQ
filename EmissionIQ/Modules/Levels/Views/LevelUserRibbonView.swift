//
//  LevelUserRibbonView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 07/03/2024.
//

import SwiftUI

// LevelUserRibbonView displays the user's ID in a ribbon
struct LevelUserRibbonView: View {
    @StateObject var privateDataManager = PrivateDataManager.shared
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    
                    Ribbon()
                        .fill(.primaryGreen)
                        .frame(height: 31)
                    
                    Capsule()
                        .fill(.primaryGreen)
                        .stroke(Color(.systemBackground), lineWidth: 6)
                        .frame(width: geometry.size.width * 0.82, height: 50)
                    
                }
                
                Text(privateDataManager.userId ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
            }
            .padding(.bottom)
            .onAppear {
                Task {
                    try await _ = privateDataManager.fetchUserId()
                }
            }
        }
    }
}

#Preview {
    LevelUserRibbonView()
}
