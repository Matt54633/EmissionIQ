//
//  Journey.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 27/02/2024.
//

import Foundation
import SwiftData

// Journey model to store all data about a user's journeys
@Model
final class Journey: Identifiable {
    var id: String = ""
    var startLocationName: String = ""
    var endLocationName: String = ""
    var startCoordinate: [Float] = [0.0, 0.0]
    var endCoordinate: [Float] = [0.0, 0.0]
    var method: String = ""
    var distance: Float = 0.0
    var date: Date = Date()
    var isReturn: Bool = false
    var imageName: String = ""
    var carbonProduced: Float = 0.0
    var xp: Int = 0
    
    // when creating a journey, use a unique ID to conform to the Identifiable protocol
    init(startLocationName: String, endLocationName: String, startCoordinate: [Float], endCoordinate: [Float], method: String, distance: Float, date: Date, isReturn: Bool) {
        self.id = UUID().uuidString
        self.startLocationName = startLocationName
        self.endLocationName = endLocationName
        self.startCoordinate = startCoordinate
        self.endCoordinate = endCoordinate
        self.method = method
        self.date = date
        self.isReturn = isReturn
        updateJourney(distance: distance, method: method, isReturn: isReturn)
    }
    
    // set transport type specifics and use conversion factors
    func updateJourney(distance: Float, method: String, isReturn: Bool) {
        self.distance = isReturn ? distance * 2 : distance
        
        switch method {
        case "car":
            self.imageName = "car"
            self.carbonProduced = Float(self.distance) *  0.27331
            self.xp = 100
        case "walk":
            self.imageName = "figure.walk"
            self.carbonProduced = Float(self.distance) * 0.0
            self.xp = 200
        case "bicycle":
            self.imageName = "bicycle"
            self.carbonProduced = Float(self.distance) * 0.0
            self.xp = 200
        case "bus":
            self.imageName = "bus"
            self.carbonProduced = Float(self.distance) * 0.16429
            self.xp = 150
        case "train":
            self.imageName = "tram"
            self.carbonProduced = Float(self.distance) * 0.05706
            self.xp = 150
        case "ferry":
            self.imageName = "ferry"
            self.carbonProduced = Float(self.distance) * 0.18120
            self.xp = 75
        case "plane":
            self.imageName = "airplane"
            self.carbonProduced = Float(self.distance) * 0.29920
            self.xp = 50
        default:
            self.imageName = "map.fill"
            self.carbonProduced = 0.0
            self.xp = 0
        }
        
        self.xp = isReturn ? self.xp * 2 : self.xp
    }
}

