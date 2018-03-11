//
//  InputIntent.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit
import SceneKit

enum InputEvents {
    
    case tap
    case pan
}

struct HorizontalScrollIntentData {
    
    var distance: CGFloat
    var rightwards: Bool
}

class InputIntent {
    
    // MARK: Properties
    
    private var inputEvents: Array<InputEvents> = [
    
        .tap,
        .pan
    ]
    
    private var sceneView: SCNView
    
    // MARK: Initializers
    
    init(sceneView _sceneView: SCNView, registerEvents: Array<InputEvents>) {
        
        self.sceneView = _sceneView
        
        for event in registerEvents {
            
            switch event {
                
            case .pan:
                
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(InputIntent.selectIntentReceived(notification:)),
                                                       name: .selectIntent,
                                                       object: nil)
                
            case .tap:
                
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(InputIntent.horizontalScrollIntentReceived(notification:)),
                                                       name: .horizontalScrollIntent,
                                                       object: nil)
            }
        }
    }
    
    // MARK: Actions
    
    @objc
    func selectIntentReceived(notification: Notification) {
        
        if let point = notification.object as? CGPoint {
        
            self.onTap(point: point, hitTestResults: self.sceneView.hitTest(point, options: [:]))
        }
    }
    
    @objc
    func horizontalScrollIntentReceived(notification: Notification) {
        
        if let horizontalScrollIntentData = notification.object as? HorizontalScrollIntentData {
            
            self.onPan(distance: horizontalScrollIntentData.distance,
                       rightwards: horizontalScrollIntentData.rightwards)
        }
    }
    
    func onTap(point: CGPoint, hitTestResults: [SCNHitTestResult]) {
        // Override
    }
    
    func onPan(distance: CGFloat, rightwards: Bool) {
        // Override
    }
}
