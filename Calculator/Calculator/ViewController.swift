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
    
    var operandStack = Array<Double>()
    
    
    @IBAction func enter(sender: UIButton) {
        userInTheMiddleOfTypingANumber = false
        operandStack.append(<#T##newElement: Double##Double#>)
    }
    
    var displayValue:Double {
        get{
            
        }
        set{
            
        }
    }

}

