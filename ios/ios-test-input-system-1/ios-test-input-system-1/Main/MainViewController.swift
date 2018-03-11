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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scene = SCNScene()
        
        self.sceneView?.showsStatistics = true
        self.sceneView?.backgroundColor = UIColor.black
        
        self.sceneView?.scene = self.scene
    }
}
