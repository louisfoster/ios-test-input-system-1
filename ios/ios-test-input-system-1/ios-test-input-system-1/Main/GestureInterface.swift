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
    func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        NotificationCenter.default.post(name: .selectIntent, object: gestureRecognizer.location(in: self.sceneView))
    }
    
    @objc
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: self.sceneView)
        
        let x = Float(translation.x)
        let anglePan = abs(x) * (Float.pi / 180.0)
        
        let object = HorizontalScrollIntentData(
            rotationMatrix: SCNMatrix4MakeRotation(anglePan, 0, x, 0),
            gestureStateEnded: gestureRecognizer.state == UIGestureRecognizerState.ended
        )
        
        NotificationCenter.default.post(name: .horizontalScrollIntent, object: object)
    }
}
