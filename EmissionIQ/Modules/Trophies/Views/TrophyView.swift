//
//  TrophyView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SceneKit
import SwiftUI

// Display a 3D trophy for an achievement
struct TrophyView: UIViewRepresentable {
    let trophyType: String
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.backgroundColor = UIColor.clear
        let scene = SCNScene(named: "\(trophyType).usdz")
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {}
}
