//
//  TransportPickerView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import SwiftUI

// View to display a picker for selecting a transportation type
struct TransportPickerView: View {
    @Binding var vehicleType: String
    
    var body: some View {
        Picker("Select Vehicle Type", selection: $vehicleType) {
            
            Image(systemName: "car").tag("car")
            Image(systemName: "figure.walk").tag("walk")
            Image(systemName: "bicycle").tag("bicycle")
            Image(systemName: "bus").tag("bus")
            Image(systemName: "tram").tag("train")
            Image(systemName: "ferry").tag("ferry")
            Image(systemName: "airplane").tag("plane")
            
        }
        .pickerStyle(.segmented)
        .padding(.bottom, 20)
    }
}

#Preview {
    TransportPickerView(vehicleType: .constant("car"))
}
