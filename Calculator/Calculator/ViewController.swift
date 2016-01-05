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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }else{
            display.text = digit
            userInTheMiddleOfTypingANumber = true
        }
    }
    
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userInTheMiddleOfTypingANumber{
            enter()
        }
        switch operation{
            // using closures 
        case"+": performOperation { $0 + $1 }
        case"−": performOperation { $1 - $0 }
        case"÷": performOperation { $1 / $0 }
        case"×": performOperation { $0 * $1 }
        case "√": performOp { sqrt($0) }
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
    
    
    var operandStack = Array<Double>()
    
    
    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print(displayValue)
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

