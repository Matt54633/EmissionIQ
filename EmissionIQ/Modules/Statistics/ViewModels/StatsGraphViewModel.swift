//
//  StatsGraphViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation

class StatsGraphViewModel: ObservableObject {
    @Published var selectedDate: Date?
    
    let chartType: String
    let axisLabel: String?
    let dataPoints: [(date: Date, value: Float)]
    
    init(chartType: String, axisLabel: String?, dataPoints: [(date: Date, value: Float)]) {
        self.chartType = chartType
        self.axisLabel = axisLabel
        self.dataPoints = dataPoints
    }
    
    // display a number of data points based on how many are available
    var displayDataPoints: [(date: Date, value: Float)] {
        dataPoints.count > 20 ? aggregateDataPoints(dataPoints) : dataPoints
    }
    
    // calculate the selectedDataPoint information
    var selectedDataPoint: (date: Date, value: Float)? {
        guard let selectedDate = selectedDate else { return nil }
        return displayDataPoints.min(by: { abs($0.date.timeIntervalSince(selectedDate)) < abs($1.date.timeIntervalSince(selectedDate)) })
    }
    
    // aggregate data points into months if number of data points is > 30
    func aggregateDataPoints(_ dataPoints: [(date: Date, value: Float)]) -> [(date: Date, value: Float)] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: dataPoints) { dataPoint in
            calendar.date(from: calendar.dateComponents([.year, .month], from: dataPoint.date))!
        }
        return grouped.map { month, dataPoints in
            let averageValue = dataPoints.map { $0.value }.reduce(0, +) / Float(dataPoints.count)
            return (date: month, value: averageValue)
        }.sorted { $0.date < $1.date }
    }
}
