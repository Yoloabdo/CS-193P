//
//  BlocksBehavior.swift
//  BreakOut
//
//  Created by abdelrahman mohamed on 3/20/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class BlocksBehavior: UIDynamicBehavior {

    
    let gravity = UIGravityBehavior()
    
    let push = UIPushBehavior()
    
    lazy var collider: UICollisionBehavior = {
        let lazyColide: UICollisionBehavior = UICollisionBehavior()
        lazyColide.translatesReferenceBoundsIntoBoundary = true
        return lazyColide as UICollisionBehavior
    }()
    
    lazy var dropBehavior: UIDynamicItemBehavior = {
        let lazilyBehave = UIDynamicItemBehavior()
        lazilyBehave.elasticity = 0.9
        return lazilyBehave
    }()
    
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(dropBehavior)
        addChildBehavior(collider)
    }
    
    func addView(view: UIView){
        dynamicAnimator?.referenceView?.addSubview(view)
//        gravity.addItem(view)
        collider.addItem(view)
        dropBehavior.addItem(view)
    }
    
    func removeView(view: UIView){
//        gravity.removeItem(view)
        collider.removeItem(view)
        dropBehavior.removeItem(view)
        view.removeFromSuperview()
    }
    
    
    func addBarrier(path: UIBezierPath, name: String){
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }

}
