//
//  BaddleBehavior.swift
//  BreakOut
//
//  Created by abdelrahman mohamed on 3/20/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class BaddleBehavior: UIDynamicBehavior {
    
    
    lazy var collider: UICollisionBehavior = {
        let lazyColide: UICollisionBehavior = UICollisionBehavior()
        lazyColide.translatesReferenceBoundsIntoBoundary = true
        return lazyColide as UICollisionBehavior
    }()
    
  

    override init() {
        super.init()
        addChildBehavior(collider)
    }
    
    
    func addView(view: UIView){
        dynamicAnimator?.referenceView?.addSubview(view)
        collider.addItem(view)
    }

}
