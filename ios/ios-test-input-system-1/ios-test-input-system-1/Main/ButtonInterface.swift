//
//  ButtonInterface.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit
import SceneKit

class ButtonInterface {
    
    // MARK: Properties
    
    private var panLeftButton: UIButton
    
    private var panRightButton: UIButton
    
    private var tapButton: UIButton
    
    // MARK: Initializers
    
    init(panLeftButton _panLeftButton: UIButton, panRightButton _panRightButton: UIButton, tapButton _tapButton: UIButton) {
        
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
        
        NotificationCenter.default.post(name: .horizontalScrollIntent,
                                        object: HorizontalScrollIntentData(rotationMatrix: SCNMatrix4MakeRotation(0.5, 0, -50, 0), gestureStateEnded: true))
    }
    
    @objc
    private func panRightButtonTouchUpInside(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: .horizontalScrollIntent,
                                        object: HorizontalScrollIntentData(rotationMatrix: SCNMatrix4MakeRotation(0.5, 0, 50, 0), gestureStateEnded: true))
    }
    
    @objc
    private func tapButtonTouchUpInside(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: .selectIntent, object: CGPoint(x: 260.0, y: 270.0))
    }
}
