//
//  JourneyViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation
import MapKit

class JourneyViewModel: ObservableObject {
    @Published var startCoordinate: CLLocationCoordinate2D?
    @Published var endCoordinate: CLLocationCoordinate2D?
    @Published var routeLine: MKPolyline?
    @Published var route: MKRoute?
    
    // geocode the start and end locations for a journey to get coordinate values
    func getCoordinates(startCoord: [Float], endCoord: [Float], journey: Journey) {
        DispatchQueue.main.async {
            self.startCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(startCoord[0]), longitude: CLLocationDegrees(startCoord[1]))
            
            self.endCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(endCoord[0]), longitude: CLLocationDegrees(endCoord[1]))
            
            self.getRoute(transportType: journey.method)
        }
    }
    
    // calculate and then set the route to be displayed on the Journey Map View
    func getRoute(transportType: String) {
        guard let startCoordinate = startCoordinate, let endCoordinate = endCoordinate else { return }
        
        let startPlacemark = MKPlacemark(coordinate: startCoordinate)
        let endPlacemark = MKPlacemark(coordinate: endCoordinate)
        let directionRequest = MKDirections.Request()
        
        directionRequest.source = MKMapItem(placemark: startPlacemark)
        directionRequest.destination = MKMapItem(placemark: endPlacemark)
        
        // change transport type to provide more accruate routing
        switch transportType {
        case "car":
            directionRequest.transportType = .automobile
        case "walk":
            directionRequest.transportType = .walking
        case "bicycle":
            directionRequest.transportType = .automobile
        case "train":
            directionRequest.transportType = .transit
        case "ferry":
            directionRequest.transportType = .transit
        case "plane":
            directionRequest.transportType = .transit
        default:
            directionRequest.transportType = .automobile
        }
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { response, error in
            DispatchQueue.main.async {
                if let route = response?.routes.first {
                    self.route = route
                } else {
                    // if no route is found or available, draw a straight line between the points
                    let coordinates = [startCoordinate, endCoordinate]
                    let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
                    self.routeLine = polyline
                }
            }
        }
    }
}
