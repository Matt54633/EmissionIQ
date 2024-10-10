//
//  JourneyImpactViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import Foundation
import SwiftUI

class JourneyImpactViewModel: ObservableObject {
    @Published var impactTypes: [String] = ["total distance", "carbon impact"]
    @Published var impactData: (imageName: String, text: String)?
    @Published var alternateTransport: (imageName: String, text: String)?
    
    private let imageNames = [
        "total distance": "point.topleft.down.to.point.bottomright.curvepath",
        "carbon impact": "carbon.dioxide.cloud"
    ]
    
    // fetch the impact for a given impact type
    func fetchJourneyImpact(impactType: String, journey: Journey, allJourneys: [Journey]) {
        let imageName = imageNames[impactType] ?? "xmark"
        let impact: Float
        
        switch impactType {
        case "total distance":
            let totalDistance = Float(allJourneys.calculateTotalDistance())
            impact = totalDistance != 0 ? (Float(journey.distance) / totalDistance) * 100 : 0
        case "carbon impact":
            let totalEmissions = Float(allJourneys.calculateTotalEmissions())
            impact = totalEmissions != 0 ? (Float(journey.carbonProduced) / totalEmissions) * 100 : 0
        default:
            impact = 0
        }
        
        let impactString = impact.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", impact) : String(format: "%.1f", impact)
        let text = "\(impactString)%"
        
        impactData = (imageName, text)
    }
    
    // function to suggest an alternate transport method
    func suggestAlternateTransport(journey: Journey) {
        let carbonProduced = journey.carbonProduced
        var carbonSaved: Float
        var alternateTransportMethod: String
        var alternateTransportImageName: String
        let actionPhrases = ["walk": "Walking", "train": "Taking the train", "bus": "Taking the bus"]
        
        switch journey.method {
        case "car":
            if journey.distance < 2.5 {
                alternateTransportMethod = "walk"
                alternateTransportImageName = "figure.walk"
            } else if journey.distance > 5 && journey.distance <= 25 {
                alternateTransportMethod = "bus"
                alternateTransportImageName = "bus.fill"
            } else if journey.distance > 25 {
                alternateTransportMethod = "train"
                alternateTransportImageName = "tram.fill"
            } else {
                return
            }
        case "plane":
            if journey.distance < 500 {
                alternateTransportMethod = "train"
                alternateTransportImageName = "tram.fill"
            } else {
                return
            }
        case "bus":
            if journey.distance < 2.5 {
                alternateTransportMethod = "walk"
                alternateTransportImageName = "figure.walk"
            } else if journey.distance > 25 {
                alternateTransportMethod = "train"
                alternateTransportImageName = "tram.fill"
            } else {
                return
            }
        default:
            alternateTransport = nil
            return
        }
        
        let alternateJourney = Journey(startLocationName: journey.startLocationName, endLocationName: journey.endLocationName, startCoordinate: journey.startCoordinate, endCoordinate: journey.endCoordinate, method: alternateTransportMethod, distance: journey.distance, date: journey.date, isReturn: journey.isReturn)
        
        carbonSaved = abs(carbonProduced - alternateJourney.carbonProduced)
        
        let actionPhrase = actionPhrases[alternateTransportMethod] ?? ""
        alternateTransport = (imageName: alternateTransportImageName, text: "\(actionPhrase) would save \(String(format: "%.1f", (carbonSaved)))kg of CO₂e")
    }
}
