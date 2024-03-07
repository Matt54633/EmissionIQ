//
//  JourneyExtension.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation

// Extend Journey arrays to provide the ability to calculate journey data without duplicating functions
extension Array where Element == Journey {
    
    // calculate all emissions produced by journeys
    func calculateTotalEmissions() -> Double {
        var totalEmissions = 0.0
        for journey in self {
            totalEmissions += Double(journey.carbonProduced)
        }
        return totalEmissions
    }
    
    // calculate all distance travelled by journeys
    func calculateTotalDistance() -> Double {
        var totalDistance = 0.0
        for journey in self {
            totalDistance += Double(journey.distance)
        }
        return totalDistance
    }
    
    // calculate the percentage of emissions produced by each vehicle type
    func calculateEmissionsPercentageByVehicleType() -> [String: Float] {
        var totalEmissionsByVehicleType: [String: Float] = [:]
        let totalEmissions = self.calculateTotalEmissions()
        
        for journey in self {
            let vehicleType = journey.method
            let emissions = journey.carbonProduced
            totalEmissionsByVehicleType[vehicleType, default: 0] += Float(emissions)
        }
        
        if totalEmissions != 0 {
            for (vehicleType, emissions) in totalEmissionsByVehicleType {
                totalEmissionsByVehicleType[vehicleType] = (emissions / Float(totalEmissions)) * 100
            }
        } else {
            for (vehicleType, _) in totalEmissionsByVehicleType {
                totalEmissionsByVehicleType[vehicleType] = 0
            }
        }
        
        return totalEmissionsByVehicleType
    }
    
    // calculate the amount of carbon produced by each vehicle type
    func calculateEmissionsInKgByVehicleType() -> [String: Double] {
        var emissionsInKgByVehicleType: [String: Double] = [:]
        for journey in self {
            emissionsInKgByVehicleType[journey.method, default: 0] += Double(journey.carbonProduced)
        }
        return emissionsInKgByVehicleType
    }
    
    // calculate the most popular transport type
    func calculateMostPopularJourneyMethod() -> String? {
        let journeyMethodCounts = Dictionary(grouping: self, by: { $0.method })
            .mapValues { $0.count }
        let maxCount = journeyMethodCounts.values.max()
        
        return self.first(where: { journeyMethodCounts[$0.method] == maxCount })?.method
    }
    
    // calculate the number of journeys that emit 0 carbon
    func calculateZeroCarbonJourneysCount() -> Int {
        return self.filter { $0.carbonProduced == 0.0 }.count
    }
}
