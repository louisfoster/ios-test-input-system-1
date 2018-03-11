//
//  ScreenInterface.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit
import SceneKit

class ScreenInterface {
    
    // register events for gestures upon screen (scnview)
    // Publish appropriate notifications
    private var sceneView: SCNView
    
    init(sceneView _sceneView: SCNView) {
        
        self.sceneView = _sceneView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ScreenInterface.handleTap(_:)))
        self.sceneView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ScreenInterface.handlePan(_:)))
        self.sceneView.addGestureRecognizer(panGesture)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        
        print("Got tap gesture")
        
        NotificationCenter.default.post(name: .tap, object: nil)

        /*
        // check what nodes are tapped
        let point = gestureRecognize.location(in: self.sceneView)
        let hitResults = self.sceneView.hitTest(point, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            _ = hitResults[0]
            
        }
        */
    }
    
    @objc
    func handlePan(_ gestureRecognize: UIGestureRecognizer) {
        
        // Acknowledge direction/distance
        print("Got pan gesture")
        
        NotificationCenter.default.post(name: .pan, object: nil)
    }
}
