//
//  FactView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 16/03/2024.
//

import SwiftUI

// FactView displays a single fact
struct FactView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: FactViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
            
            if let currentFact = viewModel.currentFact?.fact {
                
                Text(currentFact)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                
            }
            
        }
        .foregroundStyle(.white)
        .padding(.horizontal)
        .frame(height: 85)
    }
}

#Preview {
    FactView(viewModel: FactViewModel())
}
