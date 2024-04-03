//
//  ReturnToggleView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 03/04/2024.
//

import SwiftUI

// View to display a toggle foa return journey
struct ReturnToggleView: View {
    @Binding var isReturn: Bool
    
    var body: some View {
        
        Picker("Return", selection: $isReturn) {
            Text("Single").tag(false)
            Text("Return").tag(true)
        }
        .pickerStyle(.segmented)
        .fontWeight(.semibold)
        .padding(.bottom, 20)
        
    }
}

#Preview {
    ReturnToggleView(isReturn: .constant(true))
}
