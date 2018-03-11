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
    
    var rotationMatrix: SCNMatrix4
    var gestureStateEnded: Bool
}

protocol InputIntentProtocol {
    
    var inputEvents: Array<InputEvents> { get }
    var sceneView: SCNView { get }
    var onSelectIntent: OnSelectIntentClosure? { get }
    var onHorizontalScrollIntent: OnHorizontalScrollIntentClosure? { get }
}

class InputIntent: InputIntentProtocol {
    
    // MARK: Properties
    
    var inputEvents: Array<InputEvents> = [
    
        .tap,
        .pan
    ]
    
    private(set) var sceneView: SCNView
    
    private(set) var onSelectIntent: OnSelectIntentClosure?
    
    private(set) var onHorizontalScrollIntent: OnHorizontalScrollIntentClosure?
    
    // MARK: Initializers
    
    init(sceneView _sceneView: SCNView,
         registerEvents: Array<InputEvents>,
         onSelectIntent _onSelectIntent: OnSelectIntentClosure?,
         onHorizontalScrollIntent _onHorizontalScrollIntent: OnHorizontalScrollIntentClosure?) {
        
        self.sceneView = _sceneView
        
        self.onSelectIntent = _onSelectIntent
        
        self.onHorizontalScrollIntent = _onHorizontalScrollIntent
        
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
        
            self.onSelectIntent?(point, self.sceneView.hitTest(point, options: [:]))
        }
    }
    
    @objc
    func horizontalScrollIntentReceived(notification: Notification) {
        
        if let horizontalScrollIntentData = notification.object as? HorizontalScrollIntentData {
            
            self.onHorizontalScrollIntent?(horizontalScrollIntentData)
        }
    }
}
