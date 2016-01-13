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
    var dotUsed = false
    
    @IBOutlet weak var historyView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func appendDigit(sender: UIButton) {
        var digit = sender.currentTitle!
        
        if digit == "." {
            if(dotUsed){
                return
            }else{
                dotUsed = true
            }
        }
        if digit == "π" {
            digit = "\(M_1_PI)"
        }
        
        
        if userInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }else{
            display.text = digit
            userInTheMiddleOfTypingANumber = true
        }
    }
    @IBAction func backSpace(sender: UIButton) {
        // to be fixed
        var num = "\(displayValue)"
        num = String(num.characters.dropLast())
        if(num.characters.count == 0) {
            num = "0.0"
        }
        displayValue = (NSNumberFormatter().numberFromString(num)?.doubleValue)!
        
    }
    
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userInTheMiddleOfTypingANumber{
            enter()
        }
        
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

        default: break
            
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
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
        historyView.text = "= "
        
    }
    
    var operandStack = Array<Double>()
    
    
    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print(displayValue)
        historyView.text = "\(historyView.text!) \(displayValue)"

    }
    
    var displayValue:Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userInTheMiddleOfTypingANumber = false
        }
    }

}

