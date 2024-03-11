//
//  Location.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 09/03/2024.
//

import Foundation
import SwiftData

// Location model used to store recent search locations
@Model
final class Location: Identifiable {
    var id: String = ""
    var creationDate: Date = Date()
    var coordinate: [Float] = [0.0, 0.0]
    var placeName: String = ""
    var placeDetail: String = ""
    var placeCountry: String = ""
    var thoroughfare: String = ""
    var subThoroughfare: String = ""
    var locality: String = ""
    var subLocality: String = ""
    var administrativeArea: String = ""
    var subAdministrativeArea: String = ""
    var postalCode: String = ""
    
    // when creating a location, use a unique ID to conform to the Identifiable protocol
    init(coordinate: [Float], placeName: String, placeDetail: String, placeCountry: String, thoroughfare: String, subThoroughfare: String, locality: String, subLocality: String, administrativeArea: String, subAdministrativeArea: String, postalCode: String) {
        
        self.id = UUID().uuidString
        self.creationDate = Date()
        self.coordinate = coordinate
        self.placeName = placeName
        self.placeDetail = placeDetail
        self.placeCountry = placeCountry
        self.thoroughfare = thoroughfare
        self.subThoroughfare = subThoroughfare
        self.locality = locality
        self.subLocality = subLocality
        self.administrativeArea = administrativeArea
        self.subAdministrativeArea = subAdministrativeArea
        self.postalCode = postalCode
    }
}
