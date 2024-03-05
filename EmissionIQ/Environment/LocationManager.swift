//
//  LocationManager.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/02/2024.
//

import Foundation
import CoreLocation

// LocationManager is responsible for requesting access to location services and also identfying the user's location
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    var onAuthorizationStatusChanged: ((CLAuthorizationStatus) -> Void)?

    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // request the permissions
    func requestLocationPermission() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()

    }
    
    // get the user's location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
    }
    
    // update the authorization status
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
        onAuthorizationStatusChanged?(status)
    }
}
