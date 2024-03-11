//
//  JourneyMapView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import SwiftUI
import MapKit
import SwiftData

// View to display the start and end locations of a single Journey along with the route between them
struct JourneyMapView: View {
    @Query private var journeys: [Journey]
    @ObservedObject var viewModel: JourneyViewModel
    @State private var position: MapCameraPosition = .automatic
    
    let startCoord: [Float]
    let endCoord: [Float]
    let journey: Journey
    
    var body: some View {
        VStack {
            
            Map(position: $position) {
                if let startCoordinate = viewModel.startCoordinate, let endCoordinate = viewModel.endCoordinate {
                    
                    Marker(journey.startLocationName, systemImage: journey.imageName, coordinate: startCoordinate)
                        .tint(.primaryGreen)
                    
                    Marker(journey.endLocationName, systemImage: journey.isReturn ? "arrow.left.arrow.right" : "flag.checkered", coordinate: endCoordinate)
                        .tint(.primaryGreen)
                    
                    // display either a calculated route, or a straight line based on route availability
                    if let routeLine = viewModel.routeLine {
                        MapPolyline(routeLine)
                            .stroke(.primaryGreen, lineWidth: 6)
                    } else if let route = viewModel.route {
                        MapPolyline(route)
                            .stroke(.primaryGreen, lineWidth: 6)
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
        }
        .padding([.bottom, .horizontal])
        .onAppear {
            viewModel.getCoordinates(startCoord: startCoord, endCoord: endCoord, journey: journey)
        }
    }
}
