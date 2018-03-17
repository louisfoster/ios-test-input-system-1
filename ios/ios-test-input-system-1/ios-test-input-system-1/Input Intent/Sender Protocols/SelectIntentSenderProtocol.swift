//
//  SelectIntentSenderProtocol.swift
//  ios-test-input-system-1
//
//  Created by Louis Foster on 17/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation
import SceneKit

protocol SelectIntentSenderProtocol {
    
    var sceneView: SCNView? { get }
}

extension SelectIntentSenderProtocol {
    
    func sendSelectIntent(_ selectIntentData: SelectIntentData) {
        
        NotificationCenter.default.post(name: .selectIntent, object: selectIntentData)
    }
}
