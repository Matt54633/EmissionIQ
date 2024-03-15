//
//  NetworkConnectionView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 15/03/2024.
//

import SwiftUI

// View to display when device is not connected to network
struct NetworkConnectionView: View {
    var body: some View {
        Image(systemName: "wifi.slash")
            .font(.subheadline)
            .foregroundStyle(.red)
            .symbolEffect(.pulse, options: .repeating)
    }
}

#Preview {
    NetworkConnectionView()
}
