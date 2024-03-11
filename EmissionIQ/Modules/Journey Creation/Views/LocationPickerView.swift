//
//  LocationPickerView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import SwiftUI

// View to allow a user to pick two locations for a journey
struct LocationPickerView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: AddJourneyViewModel
    @Binding var startLocation: String
    @Binding var endLocation: String
    @Binding var displayStartLocationSearchSheet: Bool
    @Binding var displayEndLocationSearchSheet: Bool
    @Binding var isReturn: Bool
    
    private let tip = JourneyReturnTip()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                HStack {
                    
                    LocationTextFieldView(viewModel: viewModel, location: $startLocation, displayLocationSearchSheet: $displayStartLocationSearchSheet, locationType: "start", paddingDirection: .leading, radiusValues: [100, 100, 0, 0])
                        .frame(width: geometry.size.width * 0.45)
                    
                    Spacer()
                    
                    LocationTextFieldView(viewModel: viewModel, location: $endLocation, displayLocationSearchSheet: $displayEndLocationSearchSheet, locationType: "end", paddingDirection: .trailing, radiusValues: [0, 0, 100, 100])
                        .frame(width: geometry.size.width * 0.45)
                    
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                
                Circle()
                    .fill(.primaryGreen)
                    .frame(height: 55)
                    .popoverTip(tip, arrowEdge: .top)
                
                Image(systemName: isReturn == false ? "arrow.right" : "arrow.left.arrow.right")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .contentTransition(.symbolEffect(.replace, options: .speed(3)))
                    .onTapGesture {
                        isReturn.toggle()
                    }
                
            }
            .padding(.bottom, 20)
        }
        .frame(height: 70)
    }
}
