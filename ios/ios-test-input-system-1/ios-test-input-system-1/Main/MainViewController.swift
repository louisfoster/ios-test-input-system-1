//
//  MainViewController.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit
import SceneKit

class MainViewController: UIViewController {
    
    @IBOutlet
    private var sceneView: SCNView?
    
    @IBOutlet
    private var dragLeftButton: UIButton?
    
    @IBOutlet
    private var dragRightButton: UIButton?
    
    @IBOutlet
    private var tapButton: UIButton?
    
    @IBOutlet
    private var outputLabel: UILabel?
    
    private var scene: SCNScene?
    
    // These all need to be allocated to variables, otherwise they won't work
    private var buttonInterface: ButtonInterface?
    private var gestureInterface: GestureInterface?
    private var textDisplay: TextDisplay?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scene = SCNScene()
        
        self.registerInterfaces()
        
        if let label = self.outputLabel, let scnv = self.sceneView {
        
            self.textDisplay = TextDisplay(with: label, sceneView: scnv)
        }
        
        self.addObjectsToScene()
        
        self.sceneView?.showsStatistics = true
        self.sceneView?.backgroundColor = UIColor.black
        
        self.sceneView?.scene = self.scene
    }
    
    func registerInterfaces() {
        
        if let s = self.sceneView {
        
            self.gestureInterface = GestureInterface(sceneView: s)
        }
        
        if let dlb = self.dragLeftButton, let drb = self.dragRightButton, let tb = self.tapButton {
        
            self.buttonInterface = ButtonInterface(panLeftButton: dlb, panRightButton: drb, tapButton: tb)
        }
    }
    
    func addObjectsToScene() {
        
        // Camera
        let camera = SCNNode()
        camera.camera = SCNCamera()
        self.scene?.rootNode.addChildNode(camera)
        camera.position = SCNVector3(5, 2, 0)
        camera.look(at: SCNVector3(0, 0, 0))
        
        // Cube Holder
        let cubeHolder = SCNNode()
        self.scene?.rootNode.addChildNode(cubeHolder)
        cubeHolder.position = SCNVector3(1, 0, -1)
        
        // Cube
        let cube = Cube(sceneView: self.sceneView)
        cubeHolder.addChildNode(cube)
    }
}
