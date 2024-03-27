//
//  SourcesViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 08/03/2024.
//

import Foundation

class SourcesViewModel: ObservableObject {
    @Published var sources = [Source]()
    
    // load sources from the JSON file and decode into sources Struct
    func loadSources() {
        if let url = Bundle.main.url(forResource: "sources", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                sources = try JSONDecoder().decode([Source].self, from: data)
            } catch {
                print("Error loading sources: \(error)")
            }
        }
    }
}
