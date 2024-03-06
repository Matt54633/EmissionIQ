//
//  AddJourneyViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation
import MapKit
import SwiftData
import SwiftUI

class AddJourneyViewModel: ObservableObject {
    @Published var locationNames: [MKPlacemark] = []
    @Published var startLocation: MKPlacemark?
    @Published var endLocation: MKPlacemark?
    
    private let locationManager = LocationManager()
    
    // wrapper function to decide which type of directions to fetch
    func getDirections(transportType: String) async throws -> Float {
        guard let startLocation = startLocation, let endLocation = endLocation else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Start location or end location is not set"])
        }
        
        if transportType == "bus" || transportType == "train" {
            return try await getTransitDirections(transportType: transportType, startLocation: startLocation, endLocation: endLocation)
        } else {
            return try await getNonTransitDirections(transportType: transportType, startLocation: startLocation, endLocation: endLocation)
        }
    }
    
    // fetch transit directions using the Google Maps Distance Matrix API
    func getTransitDirections(transportType: String, startLocation: MKPlacemark, endLocation: MKPlacemark) async throws -> Float {
        // make API call to Google
        let origins = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destinations = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        let mode = "transit"
        var transitMode = ""
        
        if transportType == "bus" {
            transitMode = "bus"
        } else {
            transitMode = "rail"
        }
        
        if let googleAPIKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_API_KEY") as? String {
            
            let urlString = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=\(origins)&destinations=\(destinations)&mode=\(mode)&transit_mode=\(transitMode)&key=\(googleAPIKey)"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let rows = json["rows"] as? [[String: Any]],
               let elements = rows.first?["elements"] as? [[String: Any]] {
                if let status = elements.first?["status"] as? String, status == "ZERO_RESULTS" {
                    // throw an error when the Google API does not return any directions
                    throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No directions found"])
                } else if let distance = elements.first?["distance"] as? [String: Any],
                          let value = distance["value"] as? Double {
                    let distanceInMiles = value / 1609.34
                    return Float(distanceInMiles)
                }
            } else {
                // throw an error when the JSON parsing fails
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON"])
            }
        }
        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Google API Key not found"])
    }
    
    // use Apple Maps to get directions for non transit journeys
    func getNonTransitDirections(transportType: String, startLocation: MKPlacemark, endLocation: MKPlacemark) async throws -> Float {
        
        // use MKDirections API for car, walk, bicycle, and plane journeys
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: endLocation)
        
        switch transportType {
        case "car":
            request.transportType = .automobile
        case "walk":
            request.transportType = .walking
        case "bicycle":
            request.transportType = .automobile
        case "plane", "ferry":
            // as the crow flies
            if let startLocation = startLocation.location, let endLocation = endLocation.location {
                let distanceInMiles = startLocation.distance(from: endLocation) / 1609.34
                return Float(distanceInMiles)
            } else {
                // throw an error when startLocation or endLocation is nil
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Start location or end location is not set"])
            }
        default:
            request.transportType = .automobile
        }
        
        let directions = MKDirections(request: request)
        let response = try await directions.calculate()
        
        if let route = response.routes.first {
            let distanceInMiles = route.distance / 1609.34
            return Float(distanceInMiles)
        } else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No routes found"])
        }
    }
    
    // set a location
    func setLocation(location: MKPlacemark, locationType: String, displaySearchSheet: Binding<Bool>, inputText: Binding<String>) {
        
        displaySearchSheet.wrappedValue = false
        
        if locationType == "start" {
            startLocation = location
        } else {
            endLocation = location
        }
        if let locationName = location.name {
            inputText.wrappedValue = locationName
        }
        locationNames.removeAll()
    }
    
    // function to create a journey
    func createJourney(journeyMethod: String, journeyDistance: Float, journeyDate: Date, journeyReturn: Bool, startLocationName: String, endLocationName: String) -> Journey? {
        
        if let startPlacemark = self.startLocation, let endPlacemark = self.endLocation {
            
            let startCoordinate = [Float(startPlacemark.coordinate.latitude), Float(startPlacemark.coordinate.longitude)]
            let endCoordinate = [Float(endPlacemark.coordinate.latitude), Float(endPlacemark.coordinate.longitude)]
            
            // check if start and end are not empty when creating a new journey
            guard !startLocationName.isEmpty, !endLocationName.isEmpty else {
                print("Start or end location name is empty")
                return nil
            }
            
            // create a new Journey object
            let newJourney = Journey(startLocationName: startLocationName, endLocationName: endLocationName,  startCoordinate: startCoordinate, endCoordinate: endCoordinate, method: journeyMethod, distance: journeyDistance, date: journeyDate, isReturn: journeyReturn)
            
            return newJourney
        }
        return nil
    }
    
    // function to add XP to the LevelManager
    func addXP(journey: Journey) async {
        do {
            try await LevelManager.shared.addXP(xp: journey.xp)
        } catch {
            print("Failed to add XP: \(error)")
        }
    }
    
    // function to insert a journey into the model context
    func insertJourney(journey: Journey, context: ModelContext) {
        Task {
            await self.addXP(journey: journey)
        }
        
        context.insert(journey)
    }
    
    
    // function to step through saving a journey
    func saveJourney(transportType: String, manualDistance: String, journeyDate: Date, journeyReturn: Bool) async throws -> (Bool, String?, Bool, Journey?) {
        
        let startLocationName = self.startLocation?.name ?? ""
        let endLocationName = self.endLocation?.name ?? ""
        var newJourney: Journey?
        
        if let manualDistanceFloat = Float(manualDistance) {
            // create Journey using manual distance
            newJourney = createJourney(journeyMethod: transportType, journeyDistance: manualDistanceFloat, journeyDate: journeyDate, journeyReturn: journeyReturn, startLocationName: startLocationName, endLocationName: endLocationName)
            return (false, nil, false, newJourney)
        } else {
            // attempt to fetch directions
            do {
                let journeyDistance = try await getDirections(transportType: transportType)
                // create journey using computed distance
                newJourney = createJourney(journeyMethod: transportType, journeyDistance: journeyDistance, journeyDate: journeyDate, journeyReturn: journeyReturn, startLocationName: startLocationName, endLocationName: endLocationName)
                return (false, nil, false, newJourney)
            } catch {
                return (true, "We can't yet fetch directions for your transport type between your chosen locations. Please enter a manual estimate instead!", true, nil)
            }
        }
    }
    
    // delete Journey instance from SwiftData
    func deleteJourney(journey: Journey, context: ModelContext) {
        context.delete(journey)
    }
}
