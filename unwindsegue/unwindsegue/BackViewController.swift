//
//  BackViewController.swift
//  unwindsegue
//
//  Created by abdelrahman mohamed on 3/1/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class BackViewController: UIViewController {

    let alert = UIAlertController(
        title: "Login required", message: "please enter your Login info", preferredStyle: .Alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: UIButton) {
        alert.addTextFieldWithConfigurationHandler{
            (textField) in
            textField.placeholder = "User name"
        }
        
        alert.addTextFieldWithConfigurationHandler{
            (textField) in
            textField.placeholder = "Guidance password"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "login", style: .Default) {
            (action: UIAlertAction) in
            // get password
            let tf = (self.alert.textFields?.first)! as UITextField
            if tf.text != nil {
                self.title = "loggedIn"
            }
            
            })
       
        presentViewController(alert, animated: true, completion: nil)
    }
   
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let unwinedToMvc = segue.destinationViewController as? ViewController{
            unwinedToMvc.title = "backk"
        }
    }
    


}
