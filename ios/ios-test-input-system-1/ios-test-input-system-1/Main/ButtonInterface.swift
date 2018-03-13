//
//  ButtonInterface.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit
import SceneKit

class ButtonInterface: SelectIntentSenderProtocol, HorizontalScrollIntentSenderProtocol {
    
    // MARK: Properties
    
    private(set) var sceneView: SCNView?
    
    private var panLeftButton: UIButton
    
    private var panRightButton: UIButton
    
    private var tapButton: UIButton
    
    // MARK: Initializers
    
    init(sceneView _sceneView: SCNView?, panLeftButton _panLeftButton: UIButton, panRightButton _panRightButton: UIButton, tapButton _tapButton: UIButton) {
        
        self.sceneView = _sceneView
        
        self.panLeftButton = _panLeftButton
        self.panRightButton = _panRightButton
        self.tapButton = _tapButton
        
        self.panLeftButton.addTarget(self, action: #selector(ButtonInterface.panLeftButtonTouchUpInside(_:)), for: .touchUpInside)
        
        self.panRightButton.addTarget(self, action: #selector(ButtonInterface.panRightButtonTouchUpInside(_:)), for: .touchUpInside)
        
        self.tapButton.addTarget(self, action: #selector(ButtonInterface.tapButtonTouchUpInside(_:)), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc
    private func panLeftButtonTouchUpInside(_ sender: UIButton) {
        
        self.sendHorizontalScrollIntent(HorizontalScrollIntentData(translation: -50, gestureStateEnded: true))
    }
    
    @objc
    private func panRightButtonTouchUpInside(_ sender: UIButton) {
        
        self.sendHorizontalScrollIntent(HorizontalScrollIntentData(translation: 50, gestureStateEnded: true))
    }
    
    @objc
    private func tapButtonTouchUpInside(_ sender: UIButton) {
        
        let point = CGPoint(x: 260.0, y: 270.0)
        if let hitTestResults = self.sceneView?.hitTest(point, options: [:]) {
            
            self.sendSelectIntent(SelectIntentData(hitTestResults: hitTestResults))
        }
    }
}
