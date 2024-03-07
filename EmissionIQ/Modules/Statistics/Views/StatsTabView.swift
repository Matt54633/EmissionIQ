//
//  StatsTabView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display both charts for a given chartType
struct StatsTabView: View {
    let title: String
    let subTitle: String
    let chartType: String
    let axisLabel: String?
    let journeysByMethod: [String: (count: Int, totalCarbon: Float, totalDistance: Float)]
    let dataPoints: [(date: Date, value: Float)]
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                StatsPieView(title: title, subTitle: subTitle, journeysByMethod: journeysByMethod)
                
                StatsGraphView(chartType: chartType, axisLabel: axisLabel, dataPoints: dataPoints)
                    .frame(height: geometry.size.height * 0.55)
            }
            
        }
    }
}
