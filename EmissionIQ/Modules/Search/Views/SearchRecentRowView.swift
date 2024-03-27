//
//  SearchRecentRowView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 09/03/2024.
//

import SwiftUI

// View to display recent locations on the search page
struct SearchRecentRowView: View {
    var location: Location
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(location.placeName)
                .font(.body)
            
            Text("\(location.placeDetail)\(location.placeDetail != "" ? ", " : "")\(location.locality), \(location.placeCountry)")
                .font(.caption)
            
        }
        .fontWeight(.regular)
    }
}
