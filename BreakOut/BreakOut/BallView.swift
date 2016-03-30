//
//  BallView.swift
//  BreakOut
//
//  Created by abdelrahman mohamed on 3/21/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class BallView: UIView {
    
//    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
//        return .Ellipse
//    }
    
    
   
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
     */
  
    override func layoutSubviews() {
        let image = UIImage(named: "ball")
        self.backgroundColor = UIColor(patternImage: image!)
//        self.layer.cornerRadius = 10
    }

}

