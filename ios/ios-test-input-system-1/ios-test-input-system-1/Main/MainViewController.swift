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
    
    // MARK: UI Propeties
    
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
    
    @IBOutlet
    private var deactivateButton: UIButton?
    
    @IBOutlet
    private var activateButton: UIButton?
    
    private var scene: SCNScene?
    
    private var inputIntent: InputIntent?
    
    // These all need to be allocated to variables, otherwise they won't work
    private var buttonInterface: ButtonInterface?
    private var gestureInterface: GestureInterface?
    private var textDisplay: TextDisplay?
    private var cube: Cube?
    
    // MARK: Setup
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.scene = SCNScene()
        
        self.inputIntent = InputIntent()
        
        self.registerInterfaces()
        
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
        
            self.buttonInterface = ButtonInterface(sceneView: self.sceneView, panLeftButton: dlb, panRightButton: drb, tapButton: tb)
        }
    }
    
    func addObjectsToScene() {
        
        guard let i = self.inputIntent else { return }
        
        // Text label output
        if let label = self.outputLabel, let scnv = self.sceneView {
            
            self.textDisplay = TextDisplay(with: label, sceneView: scnv, inputIntent: i)
        }
        
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
        let _cube = Cube(sceneView: self.sceneView, inputIntent: i)
        cubeHolder.addChildNode(_cube)
        self.cube = _cube
    }
    
    @IBAction
    func deactivateButtonTouchUpInside(_ sender: Any) {
        
        if let _cube = self.cube {
            
            _cube.deregisterHorizontalScrollIntentObserver()
        }
    }
    
    @IBAction
    func activateButtonTouchUpInside(_ sender: Any) {
        
        if let _cube = self.cube {
            
            _cube.registerHorizontalScrollIntentObserver()
        }
    }
    
}
