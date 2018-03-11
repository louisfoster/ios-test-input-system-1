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
}
