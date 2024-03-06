//
//  StatsGraphView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import Charts

// View to display a graph for a given statistic
struct StatsGraphView: View {
    @StateObject var viewModel: StatsGraphViewModel
    
    private let tip = StatsGraphTip()
    
    init(chartType: String, axisLabel: String?, dataPoints: [(date: Date, value: Float)]) {
        _viewModel = StateObject(wrappedValue: StatsGraphViewModel(chartType: chartType, axisLabel: axisLabel, dataPoints: dataPoints))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(viewModel.chartType)
                .modifier(ChartTitle(selectedDataPoint: viewModel.selectedDataPoint))
            
            Chart {
                ForEach(viewModel.displayDataPoints, id: \.date) { dataPoint in
                    LineMark(x: .value("Date", dataPoint.date),
                             y: .value("Value", dataPoint.value))
                    .foregroundStyle(.primaryGreen)
                }
                .symbol(.diamond)
                .lineStyle(.init(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .interpolationMethod(.monotone)
                
                
                if let selectedDataPoint = viewModel.selectedDataPoint {
                    RuleMark(x: .value("Selected", selectedDataPoint.date))
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .offset(yStart: -5)
                        .zIndex(-1)
                        .annotation(
                            position: .top, spacing: 0,
                            overflowResolution: .init(
                                x: .fit(to: .chart),
                                y: .disabled
                            )
                        ) {
                            StatsGraphOverlayView(chartType: viewModel.chartType, date: selectedDataPoint.date, value: selectedDataPoint.value)
                        }
                }
            }
            .popoverTip(tip)
            .padding()
            .chartXSelection(value: $viewModel.selectedDate)
            .chartYAxis(content: {
                AxisMarks { value in
                    AxisValueLabel {
                        if let value = value.as(Double.self) {
                            Text(String(format: "%.1f" ,value)) + Text(viewModel.axisLabel ?? "")
                        }
                    }
                }
            })
        }
        .padding(.bottom, 30)
    }
}
