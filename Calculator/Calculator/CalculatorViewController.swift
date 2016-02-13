//
//  ViewController.swift
//  Calculator
//
//  Created by abdelrahman mohamed on 1/4/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit



class CalculatorViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userInTheMiddleOfTypingANumber = false
    lazy var brain = CalculatorBrain()
    
    @IBOutlet weak var historyView: UILabel!
    
   
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        // allow dot to be entered just once.
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
        if !deleteBackSpace() {
            if !brain.popOperand(){
                displayValue = 0
            }
            historyView.text = brain.discription
        }
        
    }
    /// backspace deletes the number that user just entered, it handles it as text
    /// just to simplfy editing double number and just do it as a string only problem.
    func deleteBackSpace() -> Bool{
        if let value = display.text where value != " " {
            if value.characters.count > 0 {
                let deletedChar = value.characters.dropLast()
                display.text = String(deletedChar)
                
                // adding " " to fix the autoshrink issue
                if deletedChar.count <= 0{
                    display.text = " "
                    userInTheMiddleOfTypingANumber = false
                }
                
                return true
            }
            
        }
        return false
    }
    @IBAction func varValueinsertion(sender: UIButton) {
        if userInTheMiddleOfTypingANumber {
            enter()
        }
        brain.addOperandValueM()
        updateDisplay()
    }
    
    @IBAction func operate(sender: UIButton) {
        
        if userInTheMiddleOfTypingANumber{
            enter()
        }
        brain.performOperation(sender.currentTitle!)
        updateDisplay()
            
    }
    
    @IBAction func clearButton(sender: UIButton) {
        displayValue = 0
        historyView.text = "="
        brain = CalculatorBrain()
    }
    
    
    
    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false
        if let value = displayValue{
            brain.pushOperand(value)
        }
        updateDisplay()
    }
    
    func updateDisplay(){
        if let result = brain.evaluate() {
            displayValue = result
        } else {
            // error?
            displayValue = nil
        }
    }
    
    var displayValue:Double? {
        get{
            //nil if the contents of display.text cannot be interpreted as a Double using swift 2.0 double(string)
            return Double(display.text!) ?? nil
        }
        set {
            
            if (newValue != nil) {
                let numberFormatter = NSNumberFormatter()
                numberFormatter.numberStyle = .DecimalStyle
                numberFormatter.maximumFractionDigits = 10
                display.text = numberFormatter.stringFromNumber(newValue!)
            } else {
                if let result = brain.evaluateAndReportErrors() as? String {
                    display.text = result
                } else {
                    display.text = " "
                }
            }
            userInTheMiddleOfTypingANumber = false
            historyView.text = brain.discription != "" ? brain.discription + " =" : ""
        }
    }

}

