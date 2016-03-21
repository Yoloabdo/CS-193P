//
//  BlockView.swift
//  BreakOut
//
//  Created by abdelrahman mohamed on 3/21/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class BlockView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var color: UIColor!
    
    convenience init(frame: CGRect ,color: UIColor) {
        self.init(frame: frame)
        backgroundColor = color
        layer.borderColor = UIColor.blackColor().CGColor
        layer.borderWidth = 1.0

    }
    
  

}
