//
//  TextDisplay.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit

class TextDisplay: Input {
    
    private var textDisplayLabel: UILabel
    
    init(with _textDisplayLabel: UILabel, registerEvents: Array<InputEvents>) {
        
        self.textDisplayLabel = _textDisplayLabel
        
        super.init(registerEvents: registerEvents)
    }
    
    override func onTap() {
        
        print("overridden onTap()")
        self.textDisplayLabel.text = "TAP!"
    }
    
    override func onPan() {
        
        print("overridden onPan()")
        self.textDisplayLabel.text = "PAN!"
    }
}
