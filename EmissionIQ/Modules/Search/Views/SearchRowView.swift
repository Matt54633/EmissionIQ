//
//  SearchRowView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import MapKit

// View to display a location in the list of returned search locations
struct SearchRowView: View {
    var location: MKPlacemark
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(location.name ?? "")
                .font(.body)
            Text("\(location.thoroughfare ?? "")\(location.thoroughfare != nil ? ", " : "")\(location.locality ?? "")\(location.locality != nil && location.administrativeArea != nil ? ", " : "")\(location.administrativeArea ?? "")\(location.administrativeArea != nil && location.countryCode != nil ? ", " : "")\(location.countryCode ?? "")")
                .font(.caption)
            
        }
        .fontWeight(.regular)
    }
}
