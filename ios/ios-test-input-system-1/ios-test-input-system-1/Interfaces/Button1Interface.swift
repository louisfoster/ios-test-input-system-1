//
//  Button1Interface.swift
//  ios-test-input-system-1
//
//  Created by Louis Foster on 17/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation
import SceneKit

class Button1Interface: RotateIntentSenderProtocol {
    
    // MARK: Properties
    
    private(set) var sceneView: SCNView?
    
    private var rotateButton: UIButton
    
    // MARK: Initializers
    
    init(sceneView _sceneView: SCNView?, rotateButton _rotateButton: UIButton) {
        
        self.sceneView = _sceneView
        
        self.rotateButton = _rotateButton
        
        self.rotateButton.addTarget(self, action: #selector(Button1Interface.rotateButtonTouchUpInside(_:)), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc
    private func rotateButtonTouchUpInside(_ sender: UIButton) {
        
        self.sendRotateIntent(RotateIntentData(angleInDegrees: -45.0, inputType: .button1))
    }
}
