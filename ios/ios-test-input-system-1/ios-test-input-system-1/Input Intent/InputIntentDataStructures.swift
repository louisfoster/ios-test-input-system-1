//
//  InputIntentDataStructures.swift
//  ios-test-input-system-1
//
//  Created by Louis Foster on 17/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation
import SceneKit

// MARK: Select Intent

struct SelectIntentData {
    
    var hitTestResults: [SCNHitTestResult]
    var inputType: InputType
}

// MARK: Horizontal Scroll Intent

struct HorizontalScrollIntentData {
    
    var translation: Float
    var gestureStateEnded: Bool
    var inputType: InputType
}

// MARK: Rotate Intent

struct RotateIntentData {
    
    var angleInDegrees: Float
    var inputType: InputType
}

// MARK: Input Intent Type Reference

enum InputType {
    
    case screen
    case button0
    case button1
}
