//
//  EmissionsProfileBreakdownView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/03/2024.
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
            .font(.title3)
            .padding(.bottom, 5)
            .fontWeight(.semibold)
            
            ScrollView {
                Text(viewModel.getTotalEmissionsText(journeys: journeys))
            }
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            
        }
        .padding(20)
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
