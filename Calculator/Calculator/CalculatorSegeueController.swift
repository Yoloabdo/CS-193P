//
//  CalculatorSegeueController.swift
//  Calculator
//
//  Created by abdelrahman mohamed on 2/14/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class CalculatorSegeueController: CalculatorViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navcon = destination as? UINavigationController {
            destination = navcon.visibleViewController!
        }
        if let hvc = destination as? DrawingViewController{
            if let identfier = segue.identifier{
                switch identfier{
                    
                case "drawRes":
                    hvc.title = brain.discription == "" ? "Graph" :
                        brain.discription.componentsSeparatedByString(", ").last
                    hvc.program = brain.program
                default:
                    break
                }
            }
        }
    }
}
