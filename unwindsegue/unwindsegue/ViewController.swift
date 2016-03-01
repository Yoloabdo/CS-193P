//
//  ViewController.swift
//  unwindsegue
//
//  Created by abdelrahman mohamed on 3/1/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var loggedIn = false
    
    func login(){
        loggedIn = true
    }
    @IBOutlet weak var popUpitem: UIBarButtonItem!
    

    @IBAction func pop(sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "Redploy view", message: "just checking if you're okay", preferredStyle: .ActionSheet)
        let action = UIAlertAction(
            title: "first", style: .Default){
                (action: UIAlertAction) -> Void in
                
        }
        let action2 = UIAlertAction(
            title: "second", style: .Default){
                (action: UIAlertAction) -> Void in
                
        }
        let action3 = UIAlertAction(
            title: "third", style: .Destructive){
                (action: UIAlertAction) -> Void in
                
        }
        let action4 = UIAlertAction(
            title: "Cancel", style: .Cancel){
                (action: UIAlertAction) -> Void in
                
        }
        alert.addAction(action)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action4)

        // ipad popover presentation in order to tell the popover it's source. otherwise it crashes. 
        alert.modalPresentationStyle = .Popover
        let ppc = alert.popoverPresentationController
        ppc?.barButtonItem = popUpitem
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
  

    @IBAction func goBack(segue: UIStoryboardSegue){
    }
}

