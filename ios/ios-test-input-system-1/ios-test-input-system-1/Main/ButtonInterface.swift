//
//  ButtonInterface.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit

class ButtonInterface {
    
    // register events from each button
    // Publish appropriate notifications
    
    private var panLeftButton: UIButton
    
    private var panRightButton: UIButton
    
    private var tapButton: UIButton
    
    init(panLeftButton _panLeftButton: UIButton, panRightButton _panRightButton: UIButton, tapButton _tapButton: UIButton) {
        
        self.panLeftButton = _panLeftButton
        self.panRightButton = _panRightButton
        self.tapButton = _tapButton
        
        self.panLeftButton.addTarget(self, action: #selector(ButtonInterface.panLeftButtonTouchUpInside(_:)), for: .touchUpInside)
        
        self.panRightButton.addTarget(self, action: #selector(ButtonInterface.panRightButtonTouchUpInside(_:)), for: .touchUpInside)
        
        self.tapButton.addTarget(self, action: #selector(ButtonInterface.tapButtonTouchUpInside(_:)), for: .touchUpInside)
    }
    
    @objc
    private func panLeftButtonTouchUpInside(_ sender: UIButton) {
        
        print("pan left button press")
        
        NotificationCenter.default.post(name: .pan, object: nil)
    }
    
    @objc
    private func panRightButtonTouchUpInside(_ sender: UIButton) {
        
        print("pan right button press")
        
        NotificationCenter.default.post(name: .pan, object: nil)
    }
    
    @objc
    private func tapButtonTouchUpInside(_ sender: UIButton) {
        
        print("tap button press")
        NotificationCenter.default.post(name: .tap, object: nil)
    }
}
