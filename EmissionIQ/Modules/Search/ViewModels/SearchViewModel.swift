//
//  SearchViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation
import MapKit
import Combine
import SwiftData

class SearchViewModel: ObservableObject {
    @Published var locationNames: [MKPlacemark] = []
    
    var locationManager = LocationManager()
    let searchSubject = PassthroughSubject<String, Never>()
    var searchCancellable: Cancellable? = nil
    
    // debounce search requests to stay under request limit
    init() {
        locationManager.requestLocationPermission()
        searchCancellable = searchSubject
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] in self?.searchLocationRequest(locationName: $0) }
    }
    
    // search for locations using a search string
    func searchLocationRequest(locationName: String) {
        locationManager.requestLocationPermission()
        self.locationNames.removeAll()
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = locationName
        
        // use user location to provide localised search results
        if let userLocation = locationManager.userLocation {
            let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            searchRequest.region = region
        }
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            var uniqueLocations: Set<MKPlacemark> = Set()
            
            for item in response.mapItems {
                guard let _ = item.placemark.location else { continue }
                uniqueLocations.insert(item.placemark)
            }
            self.locationNames = Array(uniqueLocations)
        }
    }
    
    // function to save recent locations
    func saveRecentLocation(recentLocations: [Location], location: MKPlacemark, context: ModelContext) {
        
        if recentLocations.count == 5 {
            if let lastLocation = recentLocations.last {
                context.delete(lastLocation)
            }
        }
        
        let recentLocation = Location(
            coordinate: [Float(location.coordinate.latitude), Float(location.coordinate.longitude)],
            placeName: location.name ?? "",
            placeDetail: location.thoroughfare ?? "",
            placeCountry: location.countryCode ?? "",
            thoroughfare: location.thoroughfare ?? "",
            subThoroughfare: location.subThoroughfare ?? "",
            locality: location.locality ?? "",
            subLocality: location.subLocality ?? "",
            administrativeArea: location.administrativeArea ?? "",
            subAdministrativeArea: location.subAdministrativeArea ?? "",
            postalCode: location.postalCode ?? ""
        )
        
        context.insert(recentLocation)
    }
    
    // function to convert recent location to a MKPlacemark
    func convertToPlacemark(location: Location, locationType: String, completion: @escaping (MKPlacemark?) -> Void) {
        
        let locationString = "\(location.placeName), \(location.thoroughfare), \(location.locality), \(location.administrativeArea), \(location.postalCode), \(location.placeCountry)"
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = locationString
        
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(location.coordinate[0]), longitude: CLLocationDegrees(location.coordinate[1]))
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let placemark = response?.mapItems.first?.placemark {
                completion(placemark)
            } else {
                completion(nil)
            }
        }
    }
}

