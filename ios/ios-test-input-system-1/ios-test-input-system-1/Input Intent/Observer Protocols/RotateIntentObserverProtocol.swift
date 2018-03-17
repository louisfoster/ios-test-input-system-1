//
//  RotateIntentObserverProtocol.swift
//  ios-test-input-system-1
//
//  Created by Louis Foster on 17/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation

protocol RotateIntentObserverProtocol {
    
    var id: Int { get }
    var inputIntent: InputIntent? { get }
    func onRotateIntent(rotateIntentData: RotateIntentData)
}

extension RotateIntentObserverProtocol {
    
    func registerRotateIntentObserver() {
        
        self.inputIntent?.addRotateIntentObserver(id: self.id, onRotateIntent: self.onRotateIntent)
    }
    
    func deregisterRotateIntentObserver() {
        
        self.inputIntent?.removeRotateIntentObserver(id: self.id)
    }
}
