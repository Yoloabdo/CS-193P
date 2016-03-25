//
//  BlockView.swift
//  BreakOut
//
//  Created by abdelrahman mohamed on 3/21/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class BlockView: UIView {

    var color: UIColor!
    
    var index: Int = 0
    
    convenience init(frame: CGRect ,color: UIColor, index: Int) {
        self.init(frame: frame)
        self.index = index
        backgroundColor = color
        layer.borderColor = UIColor.blackColor().CGColor
        layer.borderWidth = 1.0

    }
    
  

}
