//
//  FactViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 16/03/2024.
//

import Foundation

class FactViewModel: ObservableObject {
    @Published var currentFact: Fact?
    
    var factList: [Fact] = []
    
    // load facts from json file
    func loadFact() {
        if let url = Bundle.main.url(forResource: "facts", withExtension: "json") {
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    self.factList = try decoder.decode([Fact].self, from: data)
                    DispatchQueue.main.async {
                        self.selectFact()
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    // select fact or change it on the hour
    func selectFact() {
        let now = Date()
        
        // check if the fact was last updated within the last hour
        if let lastUpdate = UserDefaults.standard.object(forKey: "LastFactUpdate") as? Date,
           now.timeIntervalSince(lastUpdate) < 3600,
           let savedFact = UserDefaults.standard.object(forKey: "CurrentFact") as? Data {
            
            let decoder = JSONDecoder()
            
            if let loadedFact = try? decoder.decode(Fact.self, from: savedFact) {
                currentFact = loadedFact
                return
            }
        }
        
        // if fact was updated more than an hour ago or there's no saved fact, select a new fact
        var newFact: Fact
        
        repeat {
            newFact = factList.randomElement() ?? Fact(fact: "")
        } while newFact == currentFact
        
        currentFact = newFact
        saveFact()
    }
    
    // save the fact to UserDefaults
    func saveFact() {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(currentFact)
            UserDefaults.standard.set(encoded, forKey: "CurrentFact")
            UserDefaults.standard.set(Date(), forKey: "LastFactUpdate")
        } catch {
            print("Error: \(error)")
        }
    }
}
