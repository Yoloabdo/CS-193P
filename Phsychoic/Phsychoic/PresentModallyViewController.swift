//
//  PresentModallyViewController.swift
//  Phsychoic
//
//  Created by abdelrahman mohamed on 2/7/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class PresentModallyViewController: HappinessViewController, UIPopoverPresentationControllerDelegate {
    
    
    struct History {
        static let popOver = "history"
        static let defaultsKey = "keyHistory"
    }
    
    override var happiness: Int {
        didSet{
            diagnosticHistory += [happiness]
        }
    }
    
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    

    var diagnosticHistory: [Int]{
        set{
            defaults.setObject(newValue, forKey: History.defaultsKey)
        }
        get{
            return defaults.objectForKey(History.defaultsKey) as? [Int] ?? []
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identfier = segue.identifier{
            switch identfier{
            case History.popOver:
                let view = segue.destinationViewController as! HistoryViewController
                if let ppc = view.popoverPresentationController {
                    ppc.delegate = self
                }
                view.historyDetails = "\(diagnosticHistory)"
                
            default:
                break
            }
        }
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
}
