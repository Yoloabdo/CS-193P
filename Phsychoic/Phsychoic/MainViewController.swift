//
//  ViewController.swift
//  Phsychoic
//
//  Created by abdelrahman mohamed on 2/5/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    struct segues {
        static let happiness = "happy"
        static let sadness = "sad"
        static let meh = "meh"
        static let fourth = "nothing"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        if let navcon = destination as? UINavigationController {
            destination = navcon.visibleViewController!
        }
        if let hvc = destination as? HappinessViewController{
            if let identfier = segue.identifier{
                switch identfier{
                case segues.happiness:
                    hvc.happiness = 100
                case segues.sadness:
                    hvc.happiness = 0
                case segues.fourth:
                    hvc.happiness = 20
                default:
                    hvc.happiness = 50
                }
            }
        }
        
    }

    @IBAction func movenoth(sender: UIButton) {
        performSegueWithIdentifier(segues.fourth, sender: nil)
    }
}

