//
//  ImpactViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation
import SwiftUI

class ImpactViewModel: ObservableObject {
    @Published var itemTypes: [String] = ["trees", "washing", "drying", "coffee", "wine", "bags", "beef", "carrot"]
    
    // set list item values based on the item type
    func setListItemValues(itemType: String, journeys: [Journey]) -> (image: String, color: Color, text: Text) {
        switch itemType {
            
        case "trees":
            let text =  Text("CO₂ removed yearly by ") + Text("^[\(Int((journeys.calculateTotalEmissions() / 24.62).rounded(.up))) \("Tree")](inflect: true)")
            return ("tree.fill", .primaryGreen, text)
            
        case "washing":
            let text = Text("^[\(Int((journeys.calculateTotalEmissions() / 0.7).rounded(.up))) \("Load")](inflect: true) of Washing")
            return ("washer.fill", .blue, text)
            
        case "drying":
            let text = Text("^[\(Int((journeys.calculateTotalEmissions() / 1.7).rounded(.up))) \("Load")](inflect: true) of Tumbling")
            return ("dryer.fill", .mint, text)
            
        case "coffee":
            let text = Text("^[\(Int((journeys.calculateTotalEmissions() / 0.4).rounded(.up))) \("Mug")](inflect: true) of Coffee")
            return ("mug.fill", .brown, text)
            
        case "wine":
            let text = Text("^[\(Int((journeys.calculateTotalEmissions() / 0.13).rounded(.up))) \("Glass")](inflect: true) of Wine")
            return ("wineglass.fill", .pink, text)
            
        case "bags":
            let text = Text("^[\(Int((journeys.calculateTotalEmissions() / 1.58).rounded(.up))) Single Use Plastic \("Bag")](inflect: true)")
            return ("bag.fill", .primary, text)
            
        case "beef":
            let text = Text("^[\(Int((journeys.calculateTotalEmissions() / 15.5).rounded(.up))) \("Serving")](inflect: true) of Beef (100g)")
            return ("fork.knife", .red, text)
            
        case "carrot":
            let text = Text("^[\(Int((journeys.calculateTotalEmissions() / 0.04).rounded(.up))) \("Carrot")](inflect: true)")
            return ("carrot.fill", .orange, text)
            
        default:
            return ("info", .primary, Text(""))
        }
    }
}
