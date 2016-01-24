//
//  ViewController.swift
//  Calculator
//
//  Created by abdelrahman mohamed on 1/4/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userInTheMiddleOfTypingANumber = false
    lazy var brain = CalculatorBrain()
    
    @IBOutlet weak var historyView: UILabel!
    
   
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        // to check if the dot had been used before in the entered number.
        if digit == "." {
            let text = display.text!
            if (text.characters.contains(".")){
                return
            }
        }

        
        if userInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }else{
            display.text = digit
            userInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func backSpace(sender: UIButton) {
        // backspace deletes the number that user just entered, it handles it as text
        // just to simplfy editing double number and just do it as a string only problem.
        
        var num = "\(display.text!)"
        num = String(num.characters.dropLast())
        
        if(num.characters.count == 0) {
            num = "0"
            displayValue = 0
        }
        display.text = num
        
    }
    
    
    @IBAction func operate(sender: UIButton) {
        
        if userInTheMiddleOfTypingANumber{
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation) {
                displayValue = result
            }else {
                displayValue = nil
            }
            
        }
        // adding op to the history viewtext
            
    }
    
    @IBAction func clearButton(sender: UIButton) {
        displayValue = 0
        historyView.text = "="
        
    }
    
    var operandStack = Array<Double>()
    
    
    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false
        if let value = displayValue {
            if let results = brain.pushOperand(value){
                displayValue = results
            }else{
                displayValue = nil
            }
        }
       
    }
    
    func enterOp(){
        display.text = "= \(display.text!)"
    }
    
    var displayValue:Double? {
        get{
            //nil if the contents of display.text cannot be interpreted as a Double
            if let num = NSNumberFormatter().numberFromString(display.text!) {
                return num.doubleValue
            } else {
                return nil
            }
        }
        set{
            if let value = newValue{
                display.text = "\(value)"
            }else{
                display.text = "error: nil value"
            }
            userInTheMiddleOfTypingANumber = false

        }
    }

}

