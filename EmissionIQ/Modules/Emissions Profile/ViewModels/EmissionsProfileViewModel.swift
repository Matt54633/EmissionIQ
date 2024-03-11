//
//  EmissionsProfileViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 26/03/2024.
//

import Foundation

class EmissionsProfileViewModel: ObservableObject {
    @Published var allTransportTypes = ["car", "bus", "bicycle", "train", "plane", "ferry", "walk"]
    @Published var emissionPercentagesByVehicleType: [String: Float] = [:]
    @Published var emissionKgByVehicleType: [String: Double] = [:]
    
    var middleTransportType: String {
        let middleIndex = allTransportTypes.count / 2
        return allTransportTypes[middleIndex]
    }
    
    var middleTransportTypeEmissions: Float {
        return emissionPercentagesByVehicleType[middleTransportType] ?? 0
    }
    
    // wrapper function to calculate emissions per transport type and sort
    func calculateEmissions(journeys: [Journey]) {
        self.emissionPercentagesByVehicleType = journeys.calculateEmissionsPercentageByVehicleType()
        self.emissionKgByVehicleType = journeys.calculateEmissionsInKgByVehicleType()
        self.initializeEmissionData()
        self.sortTransportTypes()
    }
    
    // default emission values for transport types with no available journeys
    private func initializeEmissionData() {
        for transportType in allTransportTypes {
            if emissionPercentagesByVehicleType[transportType] == nil {
                emissionPercentagesByVehicleType[transportType] = 0.0
            }
            if emissionKgByVehicleType[transportType] == nil {
                emissionKgByVehicleType[transportType] = 0.0
            }
        }
    }
    
    // sort transport types so most polluting type appears in middle of profile
    private func sortTransportTypes() {
        // Sort the transport types based on the emission percentages
        allTransportTypes.sort { emissionPercentagesByVehicleType[$0] ?? 0.0 > emissionPercentagesByVehicleType[$1] ?? 0.0 }
        
        let centerIndex = allTransportTypes.count / 2
        let highestEmissionTransportType = allTransportTypes.remove(at: 0)
        allTransportTypes.insert(highestEmissionTransportType, at: centerIndex)
    }
    
    // return a valid image name for each transport type
    func imageName(for transportType: String) -> String {
        switch transportType {
        case "car":
            return "car.fill"
        case "bus":
            return "bus.fill"
        case "bicycle":
            return "bicycle"
        case "train":
            return "tram.fill"
        case "plane":
            return "airplane"
        case "ferry":
            return "ferry.fill"
        case "walk":
            return "figure.walk"
        default:
            return "questionmark.circle"
        }
    }
    
    // display text about total emissions
    func getTotalEmissionsText(journeys: [Journey]) -> String {
        let totalEmissions = String(format: "%.1f", journeys.calculateTotalEmissions())
        let mostPollutingTransportType = allTransportTypes[allTransportTypes.count / 2]
        let mostPollutingTransportTypeEmissions = Int(emissionPercentagesByVehicleType[mostPollutingTransportType] ?? 0)
        let transportTypeText = allTransportTypes.isEmpty ? "" : "\(mostPollutingTransportType.capitalized) journeys produce \(mostPollutingTransportTypeEmissions)% of your total emissions - that's your most polluting transport type!"
        
        return "Since starting your EmissionIQ journey, you've generated \(totalEmissions)kg of CO₂e. \(transportTypeText)"
    }
    
    // calculate the emissions percentage for a transport type
    func emissionPercentage(for transportType: String) -> Float {
        return emissionPercentagesByVehicleType[transportType]?.rounded(.up) ?? 0.0
    }
    
    // calculate the emissions kilos for a transport type
    func emissionKg(for transportType: String) -> Float {
        return Float(emissionKgByVehicleType[transportType] ?? 0.0)
    }
}

