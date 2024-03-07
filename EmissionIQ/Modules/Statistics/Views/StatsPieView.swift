//
//  StatsPieView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import Charts

// View to display pie chart data
struct StatsPieView: View {
    @StateObject var viewModel: StatsPieViewModel
    
    init(title: String, subTitle: String, journeysByMethod: [String: (count: Int, totalCarbon: Float, totalDistance: Float)]) {
        _viewModel = StateObject(wrappedValue: StatsPieViewModel(title: title, subTitle: subTitle, journeysByMethod: journeysByMethod))
    }
    
    var body: some View {
        Chart {
            ForEach(viewModel.sortedKeys.indices, id: \.self) { index in
                SectorMark(angle: .value("Value", viewModel.value(for: index)), innerRadius: .ratio(0.825), angularInset: 2.5)
                    .cornerRadius(5)
                    .foregroundStyle(by: .value("Name", viewModel.method(for: index).capitalized))
                    .opacity(viewModel.selectedMethod == nil || viewModel.method(for: index) == viewModel.selectedMethod ? 1.0 : 0.3)
            }
        }
        .padding(EdgeInsets(top: 15, leading: 15, bottom: 10, trailing: 15))
        .chartLegend(alignment: .center, spacing: 15)
        .chartAngleSelection(value: $viewModel.selectedSegmentIndex)
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                if let plotFrame = chartProxy.plotFrame {
                    
                    StatsPieOverlayView(title: viewModel.title, subTitle: viewModel.subTitle, selectedMethod: viewModel.selectedMethod, journeysByMethod: viewModel.journeysByMethod, viewModel: viewModel)
                        .position(x: geometry[plotFrame].midX, y: geometry[plotFrame].midY)
                    
                }
            }
        }
    }
}

#Preview {
    StatsPieView(title: "Journeys", subTitle: "By transport type", journeysByMethod: [
        "Car": (count: 10, totalCarbon: 100, totalDistance: 1000),
        "Bike": (count: 5, totalCarbon: 0, totalDistance: 500),
        "Walk": (count: 15, totalCarbon: 0, totalDistance: 1500)
    ])
}
