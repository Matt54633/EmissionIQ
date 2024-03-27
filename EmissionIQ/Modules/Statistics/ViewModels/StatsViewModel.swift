//
//  StatsViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 11/03/2024.
//

import Foundation

class StatsViewModel: ObservableObject {
    @Published var journeysByMethod: [String: (count: Int, totalCarbon: Float, totalDistance: Float)] = [:]
    @Published var journeysOverTime: [(date: Date, value: Float)] = []
    @Published var distanceOverTime: [(date: Date, value: Float)] = []
    @Published var carbonEmittedOverTime: [(date: Date, value: Float)] = []
    @Published var userId: String?
    @Published var creationDate: String?
    
    private var privateDataManager = PrivateDataManager.shared
    
    // fetch the user's id
    func fetchUserId() async {
        do {
            let fetchedUser = try await privateDataManager.fetchUserId()
            DispatchQueue.main.async {
                self.userId = fetchedUser.userId
            }
        } catch {
            print("Error fetching User ID \(error)")
        }
    }
    
    // fetch the user's creationDate
    func fetchUserCreationDate() async {
        do {
            let fetchedDate = try await privateDataManager.fetchUserCreationDate()
            DispatchQueue.main.async {
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                self.creationDate = formatter.string(from: fetchedDate)
            }
        } catch {
            print("Error fetching User Creation Date \(error)")
        }
    }
    
    // calculate journeys, distance, and carbon over time
    func calculateStatsOverTime(journeys: [Journey]) {
        // prevent graph redrawing
        journeysOverTime.removeAll()
        distanceOverTime.removeAll()
        carbonEmittedOverTime.removeAll()
        
        let groupedJourneys = Dictionary(grouping: journeys, by: { Calendar.current.startOfDay(for: $0.date) })
        let sortedDates = groupedJourneys.keys.sorted()
        
        var currentDate = sortedDates.first
        var count = 0
        var totalDistance: Float = 0
        var totalCarbon: Float = 0
        
        while let current = currentDate, current <= sortedDates.last ?? Date() {
            if let journeysOnDate = groupedJourneys[current] {
                for journey in journeysOnDate {
                    count += 1
                    totalDistance += journey.distance
                    totalCarbon += journey.carbonProduced
                }
            }
            
            journeysOverTime.append((date: current, value: Float(count)))
            distanceOverTime.append((date: current, value: totalDistance))
            carbonEmittedOverTime.append((date: current, value: totalCarbon))
            
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: current)
        }
    }
    
    // calculate no. journeys per method to display in chart
    func calculateJourneysByMethod(journeys: [Journey]) {
        journeysByMethod.removeAll()
        
        let groupedJourneys = Dictionary(grouping: journeys, by: { $0.method })
        
        journeysByMethod = groupedJourneys.mapValues { journeys in
            let count = journeys.count
            let totalCarbon = journeys.reduce(0, { $0 + $1.carbonProduced })
            let totalDistance = journeys.reduce(0, { $0 + $1.distance })
            return (count: count, totalCarbon: totalCarbon, totalDistance: totalDistance)
        }
    }
}
