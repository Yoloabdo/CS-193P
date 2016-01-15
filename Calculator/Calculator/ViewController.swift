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
    
    @IBOutlet weak var historyView: UILabel!
    
   
    @IBAction func appendDigit(sender: UIButton) {
        var digit = sender.currentTitle!
        
        // to check if the dot had been used before in the entered number.
        if digit == "." {
            let text = display.text!
            if (text.characters.contains(".")){
                return
            }
        }
        // here we add pie as predefined value to the view.
        if digit == "π" {
            digit = "\(M_1_PI)"
            enter()
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
        let operation = sender.currentTitle!
        if userInTheMiddleOfTypingANumber{
            enter()
        }
        
        // adding op to the history viewtext
        historyView.text = "\(historyView.text!) (\(operation))"

        switch operation{
            // using closures 
        case"+": performOperation { $0 + $1 }
        case"−": performOperation { $1 - $0 }
        case"÷": performOperation { $1 / $0 }
        case"×": performOperation { $0 * $1 }
        case"%": performOperation { $1 % $0 }
        case"√": performOp { sqrt($0) }
        case"sin": performOp { sin($0) }
        case"cos": performOp { cos($0) }
        case"tan": performOp { tan($0) }
        case"+/-":performOp { -$0 }
        case"x²": performOp { $0 * $0 }

        default: break
            
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
            enterOp()
        }
    }
    
    func performOp(op: Double ->Double){
        if operandStack.count >= 1{
            displayValue = op(operandStack.removeLast())
            enter()
        }
    }
    
    @IBAction func clearButton(sender: UIButton) {
        operandStack.removeAll()
        displayValue = 0
        historyView.text = "="
        
    }
    
    var operandStack = Array<Double>()
    
    
    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false
        if let value = displayValue {
            operandStack.append(value)
            historyView.text = "\(historyView.text!) \(value)"
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
            display.text = "\(newValue!)"
            userInTheMiddleOfTypingANumber = false
        }
    }

}

