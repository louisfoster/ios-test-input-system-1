//
//  Cube.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation
import SceneKit

class Cube: SCNNode {
    
    private var inputIntent: InputIntent?
    private var sceneView: SCNView?
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    init(sceneView _sceneView: SCNView?) {
        
        super.init()
        
        self.name = "Cubo"
        
        let boxGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        
        // Assign a colour material for each side of the box
        let colors = [UIColor.green, // front
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
        
        self.geometry = boxGeometry
        
        self.sceneView = _sceneView
        
        if let scnv = self.sceneView {
            self.inputIntent = InputIntent(sceneView: scnv,
                                           registerEvents: [.tap, .pan],
                                           onSelectIntent: { (point, hits) in
                                            
                                                self.onTap(point, hits)
                                            },
                                           onHorizontalScrollIntent: { (horizontalScrollIntentData) in
                
                                                self.onPan(horizontalScrollIntentData)
                                            })
        }
    }
    
    private func onTap(_ point: CGPoint, _ hits: [SCNHitTestResult]) {
        
        if hits.count > 0 && hits[0].node == self {
            
            self.parent?.runAction(SCNAction.sequence([
                SCNAction.move(by: SCNVector3(0, 1, 0), duration: 0.5),
                SCNAction.move(by: SCNVector3(0, -1, 0), duration: 0.5)
            ]))
        }
    }
    
    private func onPan(_ horizontalScrollIntentData: HorizontalScrollIntentData) {
        
        // Set the rotation transform to the new matrix
        self.transform = horizontalScrollIntentData.rotationMatrix
        
        // Preserve the pivot and transformation after pan has ended
        if horizontalScrollIntentData.gestureStateEnded {
            
            let currentPivot = self.pivot
            let changePivot = SCNMatrix4Invert(self.transform)
            self.pivot = SCNMatrix4Mult(changePivot, currentPivot)
            self.transform = SCNMatrix4Identity
        }
    }
}
