//
//  ViewController.swift
//  BreakOut
//
//  Created by abdelrahman mohamed on 3/19/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var gameView: UIView!
    
    var blocksPerRow = 8
    
    var blockkSize: CGSize {
        let size = gameView.bounds.size.width / CGFloat(blocksPerRow)
        return CGSize(width: size, height: size/2)
    }

}

