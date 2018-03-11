//
//  Input.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation

enum InputEvents {
    
    case tap
    case pan
}

class Input {
    
    private var inputEvents: Array<InputEvents> = [
    
        .tap,
        .pan
    ]
    
    // Register tap, perform hit test, collect data, publish notification
    // Register pan, collect data, publish notification
    init(registerEvents: Array<InputEvents>) {
        
        for event in registerEvents {
            
            switch event {
                
            case .pan:
                
                NotificationCenter.default.addObserver(self, selector: #selector(Input.tapReceived(notification:)), name: .tap, object: nil)
                
            case .tap:
                
                NotificationCenter.default.addObserver(self, selector: #selector(Input.panReceived(notification:)), name: .pan, object: nil)
            }
        }
    }
    
    @objc
    func tapReceived(notification: Notification) {
        
        // Location
        // Hit test (first item)
        print("tap notification received")
        self.onTap()
    }
    
    @objc
    func panReceived(notification: Notification) {
        
        // Direction
        // Distance
        print("pan notification received")
        self.onPan()
    }
    
    func onTap() {
        // Override
    }
    
    func onPan() {
        // Override
    }
}
