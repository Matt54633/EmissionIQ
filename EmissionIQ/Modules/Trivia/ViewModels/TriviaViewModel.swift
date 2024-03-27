//
//  TriviaViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 21/03/2024.
//

import Foundation

class TriviaViewModel: ObservableObject {
    @Published var dailyTrivia: Trivia?
    var triviaList: [Trivia] = []
    
    // load trivia from json file
    func loadTrivia() {
        if let url = Bundle.main.url(forResource: "trivia", withExtension: "json") {
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    self.triviaList = try decoder.decode([Trivia].self, from: data)
                    DispatchQueue.main.async {
                        self.selectTrivia()
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    // select the current trivia or update it
    func selectTrivia() {
        let calendar = Calendar.current
        let now = Date()
        let today = calendar.startOfDay(for: now)
        
        // check if the trivia was last updated today
        if let lastUpdate = UserDefaults.standard.object(forKey: "LastUpdate") as? Date, calendar.isDate(lastUpdate, inSameDayAs: today),
           let savedTrivia = UserDefaults.standard.object(forKey: "DailyTrivia") as? Data {
            let decoder = JSONDecoder()
            
            if let loadedTrivia = try? decoder.decode(Trivia.self, from: savedTrivia) {
                dailyTrivia = loadedTrivia
                return
            }
        }
        
        // if the trivia wasn't updated today or there's no saved trivia, select a new trivia
        let currentIndex = UserDefaults.standard.integer(forKey: "CurrentTriviaIndex")
        let nextIndex = (currentIndex + 1) % triviaList.count
        dailyTrivia = triviaList[nextIndex]
        UserDefaults.standard.set(nextIndex, forKey: "CurrentTriviaIndex")
        
        saveTrivia()
    }
    
    // save the trivia to UserDefaults
    func saveTrivia() {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(dailyTrivia)
            UserDefaults.standard.set(encoded, forKey: "DailyTrivia")
            UserDefaults.standard.set(Date(), forKey: "LastUpdate")
        } catch {
            print("Error: \(error)")
        }
    }
}
