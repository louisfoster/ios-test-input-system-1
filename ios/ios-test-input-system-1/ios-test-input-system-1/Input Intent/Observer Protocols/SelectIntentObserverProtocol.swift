//
//  SelectIntentObserverProtocol.swift
//  ios-test-input-system-1
//
//  Created by Louis Foster on 17/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation

protocol SelectIntentObserverProtocol {
    
    var id: Int { get }
    var inputIntent: InputIntent? { get }
    func onSelectIntent(selectIntentData: SelectIntentData)
}

extension SelectIntentObserverProtocol {
    
    func registerSelectIntentObserver() {
        
        self.inputIntent?.addSelectIntentObserver(id: self.id, onSelectIntent: self.onSelectIntent)
    }
    
    func deregisterSelectIntentObserver() {
        
        self.inputIntent?.removeSelectIntentObserver(id: self.id)
    }
}
