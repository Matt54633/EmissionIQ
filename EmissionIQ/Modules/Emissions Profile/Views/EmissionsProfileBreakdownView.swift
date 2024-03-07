//
//  EmissionsProfileBreakdownView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// View to breakdown and explain the emissions profile
struct EmissionsProfileBreakdownView: View {
    @Query private var journeys: [Journey]
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = EmissionsProfileViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                
                Text("The Breakdown")
                
                Spacer()
                
                Image(systemName: "sparkles")
                    .foregroundStyle(.primaryGreen)
                
            }
            .font(UIScreen.current?.bounds.width ?? 400 > 380 ? .title3 : .body)
            .padding(.bottom, 5)
            .fontWeight(.semibold)
            
            
            Text(viewModel.getTotalEmissionsText(journeys: journeys))
                .font(UIScreen.current?.bounds.width ?? 400 > 380 ? .body : .subheadline)
            
        }
        .padding(UIScreen.current?.bounds.width ?? 400 > 380 ? 20 : 15)
        .background(RoundedRectangle(cornerRadius: 20)
            .fill(colorScheme == .dark ? .quaternary : .quinary))
        .padding()
        .onAppear {
            viewModel.calculateEmissions(journeys: journeys)
        }
    }
}

#Preview {
    EmissionsProfileBreakdownView()
}
