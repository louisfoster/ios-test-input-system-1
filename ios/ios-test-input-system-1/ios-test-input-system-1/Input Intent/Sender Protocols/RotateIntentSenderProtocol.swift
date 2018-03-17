//
//  RotateIntentSenderProtocol.swift
//  ios-test-input-system-1
//
//  Created by Louis Foster on 17/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation

protocol RotateIntentSenderProtocol {}

extension RotateIntentSenderProtocol {
    
    func sendRotateIntent(_ rotateIntentData: RotateIntentData) {
        
        NotificationCenter.default.post(name: .rotateIntent, object: rotateIntentData)
    }
}
