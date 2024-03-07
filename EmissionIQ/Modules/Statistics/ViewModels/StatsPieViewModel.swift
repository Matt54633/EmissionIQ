//
//  StatsPieViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation

class StatsPieViewModel: ObservableObject {
    @Published var selectedSegmentIndex: Int?
    
    let title: String
    let subTitle: String
    let journeysByMethod: [String: (count: Int, totalCarbon: Float, totalDistance: Float)]
    
    init(title: String, subTitle: String, journeysByMethod: [String: (count: Int, totalCarbon: Float, totalDistance: Float)]) {
        self.title = title
        self.subTitle = subTitle
        self.journeysByMethod = journeysByMethod
    }
    
    // sort the method keys
    var sortedKeys: [String] {
        journeysByMethod.keys.sorted()
    }
    
    // identify the selected method
    var selectedMethod: String? {
        guard let index = selectedSegmentIndex else { return nil }
        return findSelectedMethod(value: index, subTitle: subTitle, journeysByMethod: journeysByMethod)
    }
    
    // find the selected sector on the pie chart
    func findSelectedMethod(value: Int, subTitle: String, journeysByMethod: [String: (count: Int, totalCarbon: Float, totalDistance: Float)]) -> String? {
        var accumulatedValue: Float = 0.0
        let sortedMethods = journeysByMethod.sorted { $0.key < $1.key }
        
        let method = sortedMethods.first { (method, data) in
            accumulatedValue += getValue(for: method, subTitle: subTitle, journeysByMethod: journeysByMethod)
            return Float(value) <= accumulatedValue
        }
        
        return method?.key
    }
    
    // set the data to be used based on the title
    func getValue(for method: String, subTitle: String, journeysByMethod: [String: (count: Int, totalCarbon: Float, totalDistance: Float)]) -> Float {
        switch subTitle {
        case "Journeys":
            return Float(journeysByMethod[method]?.count ?? 0)
        case "kg CO₂e":
            return journeysByMethod[method]?.totalCarbon ?? 0
        case "Miles":
            return journeysByMethod[method]?.totalDistance ?? 0
        default:
            return 0
        }
    }
    
    // return the correct method for an index
    func method(for index: Int) -> String {
        sortedKeys[index]
    }
    
    // return the correct value for an index
    func value(for index: Int) -> Double {
        let method = self.method(for: index)
        return Double(getValue(for: method, subTitle: subTitle, journeysByMethod: journeysByMethod))
    }
}
