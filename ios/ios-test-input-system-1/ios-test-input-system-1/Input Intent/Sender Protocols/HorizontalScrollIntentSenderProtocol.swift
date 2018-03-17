//
//  HorizontalScrollIntentSenderProtocol.swift
//  ios-test-input-system-1
//
//  Created by Louis Foster on 17/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation

protocol HorizontalScrollIntentSenderProtocol {}

extension HorizontalScrollIntentSenderProtocol {
    
    func sendHorizontalScrollIntent(_ horizontalScrollIntentData: HorizontalScrollIntentData) {
        
        NotificationCenter.default.post(name: .horizontalScrollIntent, object: horizontalScrollIntentData)
    }
}
