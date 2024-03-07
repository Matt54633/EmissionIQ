//
//  JourneysListViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation

class JourneysListViewModel: ObservableObject {
    
    // group journeys by their week to create sections
    func groupJourneysByWeek(journeys: [Journey]) -> [(Date, [Journey])] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: journeys) { journey -> Date in
            let date = journey.date
            let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
            return calendar.date(from: components) ?? date
        }
        return grouped.sorted(by: { $0.0 > $1.0 })
    }
}

