//
//  TextDisplay.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit
import SceneKit

class TextDisplay: InputIntent {
    
    private var textDisplayLabel: UILabel
    private var sceneView: SCNView
    
    convenience init(with _textDisplayLabel: UILabel, sceneView _sceneView: SCNView) {
        
        self.init(_textDisplayLabel, _sceneView, [.pan, .tap])
    }
    
    private init(_ _textDisplayLabel: UILabel, _ _sceneView: SCNView, _ registerEvents: Array<InputEvents>) {
        
        self.textDisplayLabel = _textDisplayLabel
        self.sceneView = _sceneView
        
        super.init(sceneView: _sceneView, registerEvents: registerEvents)
    }
    
    override func onTap(point: CGPoint, hitTestResults: [SCNHitTestResult]) {
        
        var text = """
        TAP!
        Point: \(point)\n
        """
        
        if hitTestResults.count > 0 {
            
            text += "\(hitTestResults[0])"
        }
        
        self.textDisplayLabel.text = text
    }
    
    override func onPan(distance: CGFloat, rightwards: Bool) {
    
        let text = """
        PAN!
        Distance: \(distance)
        Rightwards: \(rightwards)
        """
        
        self.textDisplayLabel.text = text
    }
}
