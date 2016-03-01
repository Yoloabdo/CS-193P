//
//  ViewController.swift
//  DropIt
//
//  Created by abdelrahman mohamed on 3/1/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController {

    @IBOutlet weak var viewGame: UIView!
  
    var dropsPerRow = 10
    var dropSize: CGSize {
        let size = viewGame.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    @IBAction func drop(sender: UITapGestureRecognizer) {
        drop()
    }
    
    func drop() {
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.random
        
        viewGame.addSubview(dropView)
    }
}


private extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

private extension UIColor{
    class var random: UIColor {
        switch arc4random() % 5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.redColor()
        case 2: return UIColor.blueColor()
        case 3: return UIColor.orangeColor()
        case 4: return UIColor.purpleColor()
        default: return UIColor.blackColor()
        }
    }
}