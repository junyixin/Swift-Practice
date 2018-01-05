//
//  ViewController.swift
//  Calculator
//
//  Created by junyixin on 04/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    // 是否是编辑状态
    var isTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if isTyping {
            displayLabel.text = displayLabel.text! + digit
        } else {
            displayLabel.text = digit
            isTyping = true
        }
    }
    
    var displayValue: Double {
        get {
            return Double(displayLabel.text!)!
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    private var brain = CalcultorModel()
    
    @IBAction func digitOperation(_ sender: UIButton) {
        
        if isTyping {
            brain.setOperand(displayValue)
            isTyping = false
        }
        
        if let symbol = sender.currentTitle {
            brain.perfromOperation(symbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
    }
}

