//
//  ViewController.swift
//  Cassini
//
//  Created by abdelrahman mohamed on 2/12/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct ButtonSegue {
        static let Ca = "Cassini"
        static let Ea = "Earth"
        static let Sa = "Saturn"
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifire = segue.identifier{
            if let tvc = segue.destinationViewController as? ImageViewController{
                switch identifire {
                case ButtonSegue.Ca:
                    tvc.imageURL = DemoURL.NASA.Cassini
                    tvc.title = ButtonSegue.Ca
                case ButtonSegue.Ea:
                    tvc.imageURL = DemoURL.NASA.Earth
                    tvc.title = ButtonSegue.Ea
                case ButtonSegue.Sa:
                    tvc.imageURL = DemoURL.NASA.Saturn
                    tvc.title = ButtonSegue.Sa
                default:
                    break
                }

            }
        }
    }
    

}

