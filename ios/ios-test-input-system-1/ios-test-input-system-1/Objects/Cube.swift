//
//  Cube.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation
import SceneKit

class Cube: SCNNode, SelectIntentObserverProtocol, HorizontalScrollIntentObserverProtocol, RotateIntentObserverProtocol {
    
    private(set) var id: Int
    private(set) var sceneView: SCNView?
    private(set) var inputIntent: InputIntent?
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("Use Cube.init(SCNView, InputIntent)")
    }
    
    init(sceneView _sceneView: SCNView?, inputIntent _inputIntent: InputIntent) {
        
        self.id = 1
        
        super.init()
        
        self.sceneView = _sceneView
        self.inputIntent = _inputIntent
        
        let boxGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        
        // Assign a colour material for each side of the box
        let colors = [
            UIColor.green, // front
            UIColor.red, // right
            UIColor.blue, // back
            UIColor.yellow, // left
            UIColor.purple, // top
            UIColor.gray] // bottom
        
        let sideMaterials = colors.map { color -> SCNMaterial in
            let material = SCNMaterial()
            material.diffuse.contents = color
            material.locksAmbientWithDiffuse = true
            return material
        }
        
        boxGeometry.materials = sideMaterials
        
        self.name = "Cubo"
        
        self.geometry = boxGeometry
        
        self.registerSelectIntentObserver()
        self.registerHorizontalScrollIntentObserver()
        self.registerRotateIntentObserver()
    }
    
    func onSelectIntent(selectIntentData: SelectIntentData) {
        
        let hits = selectIntentData.hitTestResults
        if hits.count > 0 && hits[0].node == self {
            
            self.parent?.runAction(SCNAction.sequence([
                SCNAction.move(by: SCNVector3(0, 1, 0), duration: 0.5),
                SCNAction.move(by: SCNVector3(0, -1, 0), duration: 0.5)
                ]))
        }
    }
    
    func onHorizontalScrollIntent(horizontalScrollIntentData: HorizontalScrollIntentData) {
        
        // Set the rotation transform to the new matrix
        let x = horizontalScrollIntentData.translation
        let anglePan = abs(x) * (Float.pi / 180.0)
        self.transform = SCNMatrix4MakeRotation(anglePan, 0, x, 0)
        
        // Preserve the pivot and transformation after pan has ended
        if horizontalScrollIntentData.gestureStateEnded {
            
            let currentPivot = self.pivot
            let changePivot = SCNMatrix4Invert(self.transform)
            self.pivot = SCNMatrix4Mult(changePivot, currentPivot)
            self.transform = SCNMatrix4Identity
        }
    }
    
    func onRotateIntent(rotateIntentData: RotateIntentData) {
        
        let angleInRadians = rotateIntentData.angleInDegrees / 180.0 * Float.pi
        
        self.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(angleInRadians), z: 0, duration: 0.3)) {
            
            // Necessary if we are combining the action with the scroll gesture
            let currentPivot = self.pivot
            let changePivot = SCNMatrix4Invert(self.transform)
            self.pivot = SCNMatrix4Mult(changePivot, currentPivot)
            self.transform = SCNMatrix4Identity
        }
    }
}
