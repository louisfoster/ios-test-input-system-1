//
//  InputIntent.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit
import SceneKit

// MARK: Input Intent

protocol InputIntentProtocol {
    
    var selectIntentObservers: Dictionary<Int, OnSelectIntentClosure> { get }
    var horizontalScrollIntentObservers: Dictionary<Int, OnHorizontalScrollIntentClosure> { get }
    var rotateIntentObservers: Dictionary<Int, OnRotateIntentClosure> { get }
    
    func selectIntentReceived(notification: Notification)
    func horizontalScrollIntentReceived(notification: Notification)
    func rotateIntentReceived(notification: Notification)
    
    func addSelectIntentObserver(id: Int, onSelectIntent: @escaping OnSelectIntentClosure)
    func addHorizontalScrollIntentObserver(id: Int, onHorizontalScrollIntent: @escaping OnHorizontalScrollIntentClosure)
    func addRotateIntentObserver(id: Int, onRotateIntent: @escaping OnRotateIntentClosure)
    
    func removeSelectIntentObserver(id: Int)
    func removeHorizontalScrollIntentObserver(id: Int)
    func removeRotateIntentObserver(id: Int)
}

class InputIntent: InputIntentProtocol {
    
    // MARK: Properties
    
    private(set) var selectIntentObservers: Dictionary<Int, OnSelectIntentClosure>
    private(set) var horizontalScrollIntentObservers: Dictionary<Int, OnHorizontalScrollIntentClosure>
    private(set) var rotateIntentObservers: Dictionary<Int, OnRotateIntentClosure>

    // MARK: Initializers
    
    init() {
        
        self.selectIntentObservers = [:]
        self.horizontalScrollIntentObservers = [:]
        self.rotateIntentObservers = [:]
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(InputIntent.selectIntentReceived(notification:)),
                                               name: .selectIntent,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(InputIntent.horizontalScrollIntentReceived(notification:)),
                                               name: .horizontalScrollIntent,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(InputIntent.rotateIntentReceived(notification:)),
                                               name: .rotateIntent,
                                               object: nil)
    }
    
    // MARK: On Notification (Intent Received)
    
    @objc
    func selectIntentReceived(notification: Notification) {
        
        if let selectIntentData = notification.object as? SelectIntentData {
        
            for (_, onSelectIntent) in self.selectIntentObservers {
                
                onSelectIntent(selectIntentData)
            }
        }
    }
    
    @objc
    func horizontalScrollIntentReceived(notification: Notification) {
        
        if let horizontalScrollIntentData = notification.object as? HorizontalScrollIntentData {
            
            for (_, onHorizontalScrollIntent) in self.horizontalScrollIntentObservers {
                
                onHorizontalScrollIntent(horizontalScrollIntentData)
            }
        }
    }
    
    @objc
    func rotateIntentReceived(notification: Notification) {
        
        if let rotateIntentData = notification.object as? RotateIntentData {
            
            for (_, onRotateIntent) in self.rotateIntentObservers {
                
                onRotateIntent(rotateIntentData)
            }
        }
    }
    
    // MARK: Add Intent Observer
    
    func addSelectIntentObserver(id: Int, onSelectIntent: @escaping OnSelectIntentClosure) {
        
        self.selectIntentObservers[id] = onSelectIntent
    }
    
    func addHorizontalScrollIntentObserver(id: Int, onHorizontalScrollIntent: @escaping OnHorizontalScrollIntentClosure) {
        
        self.horizontalScrollIntentObservers[id] = onHorizontalScrollIntent
    }
    
    func addRotateIntentObserver(id: Int, onRotateIntent: @escaping OnRotateIntentClosure) {
    
        self.rotateIntentObservers[id] = onRotateIntent
    }
    
    // MARK: Remove Intent Observer
    
    func removeSelectIntentObserver(id: Int) {
        
        self.selectIntentObservers[id] = nil
    }
    
    func removeHorizontalScrollIntentObserver(id: Int) {
        
        self.horizontalScrollIntentObservers[id] = nil
    }
    
    func removeRotateIntentObserver(id: Int) {
        
        self.rotateIntentObservers[id] = nil
    }
}
