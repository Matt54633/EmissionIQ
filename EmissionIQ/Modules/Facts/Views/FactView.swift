//
//  FactView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// FactView displays a single fact
struct FactView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var viewModel: FactViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            GlassEffectView(image: "GreenMesh", cornerRadius: 20)
            
            if let currentFact = viewModel.currentFact?.fact {
                Text(currentFact)
                    .font(horizontalSizeClass == .compact ? .subheadline : .headline)
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
