//
//  ViewController.swift
//  Trx
//
//  Created by abdelrahman mohamed on 3/14/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        let appDelegate = UIApplication.sharedApplication().delegate
        
        center.addObserverForName(GPXURL.notification , object: appDelegate, queue: queue) {
            notification in
            if let url = notification.userInfo?[GPXURL.key] as? NSURL {
                self.textView.text = "\(url)"
            }
        }
    }

    

}

