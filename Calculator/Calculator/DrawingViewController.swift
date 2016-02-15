//
//  DrawingViewController.swift
//  Calculator
//
//  Created by abdelrahman mohamed on 2/13/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {

    var axesDrawer: AxesDrawer?
    
    @IBOutlet weak var drawer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        axesDrawer = AxesDrawer(color: UIColor.blackColor())
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
