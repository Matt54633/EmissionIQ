//
//  EmissionIQApp.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 30/01/2024.
//

import SwiftUI
import TipKit

@main
struct EmissionIQApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .fontDesign(.rounded)
                .dynamicTypeSize(.small ... .large)
                .modifier(MacModifier())
                .task {
                    try? Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
        }
        .defaultSize(width: 1350, height: 900)
        .windowResizability(.contentSize)
        .modelContainer(for: [Journey.self, Location.self, Trophy.self, ReadArticle.self])
    }
}
