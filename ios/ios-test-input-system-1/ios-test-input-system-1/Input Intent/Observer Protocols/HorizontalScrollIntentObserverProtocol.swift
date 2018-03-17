//
//  HorizontalScrollIntentObserverProtocol.swift
//  ios-test-input-system-1
//
//  Created by Louis Foster on 17/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation

protocol HorizontalScrollIntentObserverProtocol {
    
    var id: Int { get }
    var inputIntent: InputIntent? { get }
    func onHorizontalScrollIntent(horizontalScrollIntentData: HorizontalScrollIntentData)
}

extension HorizontalScrollIntentObserverProtocol {
    
    func registerHorizontalScrollIntentObserver() {
        
        self.inputIntent?.addHorizontalScrollIntentObserver(id: self.id, onHorizontalScrollIntent: self.onHorizontalScrollIntent)
    }
    
    func deregisterHorizontalScrollIntentObserver() {
        
        self.inputIntent?.removeHorizontalScrollIntentObserver(id: self.id)
    }
}
