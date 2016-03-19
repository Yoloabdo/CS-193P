//
//  DropItBehavior.swift
//  DropIt
//
//  Created by abdelrahman mohamed on 3/1/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class DropItBehavior: UIDynamicBehavior {

    let gravity = UIGravityBehavior()

    
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
    
    func addDrop(drop: UIView){
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
        dropBehavior.addItem(drop)
    }
    
    func removeDrop(drop: UIView){
        gravity.removeItem(drop)
        collider.removeItem(drop)
        dropBehavior.removeItem(drop)
        drop.removeFromSuperview()
    }
    
    
    func addBarrier(path: UIBezierPath, name: String){
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
}
