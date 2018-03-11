//
//  GestureInterface.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit
import SceneKit

class GestureInterface {
    
    // MARK: Properties
    
    private var sceneView: SCNView
    private var previousPanPoint: CGPoint?
    
    // MARK: Initializers
    
    init(sceneView _sceneView: SCNView) {
        
        self.sceneView = _sceneView
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(GestureInterface.handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.sceneView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(GestureInterface.handlePan(_:)))
        panGesture.maximumNumberOfTouches = 1
        self.sceneView.addGestureRecognizer(panGesture)
    }
    
    // MARK: Actions
    
    @objc
    func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        
        NotificationCenter.default.post(name: .selectIntent, object: gestureRecognizer.location(in: self.sceneView))
    }
    
    @objc
    func handlePan(_ gestureRecognizer: UIGestureRecognizer) {
        
        let point = gestureRecognizer.location(in: self.sceneView)
        var object: HorizontalScrollIntentData?
        
        if let previous = self.previousPanPoint {
            
            let line = previous.x - point.x
            
            object = HorizontalScrollIntentData(distance: abs(line) / self.sceneView.bounds.width, rightwards: line < 0)
        }
        
        self.previousPanPoint = point
        
        NotificationCenter.default.post(name: .horizontalScrollIntent, object: object)
    }
}
