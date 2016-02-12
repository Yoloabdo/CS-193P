//
//  ViewController.swift
//  LoginLayout
//
//  Created by abdelrahman mohamed on 2/10/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var secured = false { didSet{ updateUI() } }
    var loggedInUser: User? { didSet{ updateUI() } }
    
    var image: UIImage? {
        get{
           return imageView.image
        }
        set{
            imageView.image = newValue
            if let constrainedView = imageView {
                if let newImage = newValue {
                    aspectRatioConstraint = NSLayoutConstraint(item: constrainedView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Height,
                        multiplier: newImage.aspectRatio,
                        constant: 0)
                }else{
                    aspectRatioConstraint = nil
                }
            }
        }
    }
    var aspectRatioConstraint: NSLayoutConstraint?{
        willSet{
            if let exisitngConstraing = aspectRatioConstraint{
                view.removeConstraint(exisitngConstraing)
            }
        }
        didSet{
            if let newConstraint = aspectRatioConstraint{
                view.addConstraint(newConstraint)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    

    func updateUI(){
        passwordField.secureTextEntry = secured
        passwordLabel.text = secured ? "Secured password" : "Password"
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
        image = loggedInUser?.image
    }
    
    @IBAction func passToggle() {
        secured = !secured
    }
    @IBAction func loginButton() {
        loggedInUser = User.login(usernameField.text ?? "", password: passwordField.text ?? "")
    }
}

extension User{
    var image: UIImage? {
        if let image = UIImage(named: login){
            return image
        }else{
            return UIImage(named: "unknown_user")
        }
    }
}

extension UIImage{
    var aspectRatio: CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}

