//
//  TextDisplay.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit
import SceneKit

class TextDisplay: SelectIntentObserverProtocol, HorizontalScrollIntentObserverProtocol {
    
    private(set) var id: Int
    private var textDisplayLabel: UILabel
    private(set) var sceneView: SCNView?
    private(set) var inputIntent: InputIntent?
    
    init(with _textDisplayLabel: UILabel, sceneView _sceneView: SCNView, inputIntent _inputIntent: InputIntent) {
        
        self.id = 0
        self.textDisplayLabel = _textDisplayLabel
        self.sceneView = _sceneView
        self.inputIntent = _inputIntent
        
        self.registerSelectIntentObserver()
        self.registerHorizontalScrollIntentObserver()
    }
    
    func onSelectIntent(selectIntentData: SelectIntentData) {
        
        var text = """
        TAP!
        Point: \(selectIntentData.point)\n
        """
        
        let hits = selectIntentData.hitTestResults
        
        if hits.count > 0, let name = hits[0].node.name {
            
            text += "Hit: \(name)"
        }
        
        self.textDisplayLabel.text = text
    }
    
    func onHorizontalScrollIntent(horizontalScrollIntentData: HorizontalScrollIntentData) {
        
        let text = """
        PAN!
        Has translation: \(String(describing: horizontalScrollIntentData.rotationMatrix).prefix(10))
        Has ended: \(horizontalScrollIntentData.gestureStateEnded)
        """
        
        self.textDisplayLabel.text = text
    }
}
