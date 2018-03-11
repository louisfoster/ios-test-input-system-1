//
//  TextDisplay.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit
import SceneKit

class TextDisplay {
    
    private var textDisplayLabel: UILabel
    var sceneView: SCNView
    private var inputIntent: InputIntent?
    
    convenience init(with _textDisplayLabel: UILabel, sceneView _sceneView: SCNView) {
        
        self.init(_textDisplayLabel, _sceneView, [.pan, .tap])
    }
    
    private init(_ _textDisplayLabel: UILabel, _ _sceneView: SCNView, _ registerEvents: Array<InputEvents>) {
        
        self.textDisplayLabel = _textDisplayLabel
        self.sceneView = _sceneView
        self.inputIntent = InputIntent(sceneView: self.sceneView,
                                       registerEvents: registerEvents,
                                       onSelectIntent: { (point, hits) in
                                        
                                            self.onTap(point, hits)
                                       },
                                       onHorizontalScrollIntent: { (horizontalScrollIntentData) in
            
                                            self.onPan(horizontalScrollIntentData)
                                       })
    }
    
    func onTap(_ point: CGPoint, _ hitTestResults: [SCNHitTestResult]) {
        
        var text = """
        TAP!
        Point: \(point)\n
        """
        
        if hitTestResults.count > 0, let name = hitTestResults[0].node.name {
            
            text += "Hit: \(name)"
        }
        
        self.textDisplayLabel.text = text
    }
    
    func onPan(_ horizontalScrollIntentData: HorizontalScrollIntentData) {
    
        let text = """
        PAN!
        Has translation: \(String(describing: horizontalScrollIntentData.rotationMatrix).prefix(10))
        Has ended: \(horizontalScrollIntentData.gestureStateEnded)
        """
        
        self.textDisplayLabel.text = text
    }
}
