//
//  HitBallBehavior.swift
//  BreakOut
//
//  Created by abdelrahman mohamed on 3/20/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class Behavior: UIDynamicBehavior {
    
//    all behaviors should be declared here, the varient is in adding the selected views to which behavior.
    

    let gravity = UIGravityBehavior()
    
    lazy var push: UIPushBehavior = {
    
        let lazyPush = UIPushBehavior(items: [UIDynamicItem](), mode: .Instantaneous)
        return lazyPush
        
    }()
    
    lazy var collider: UICollisionBehavior = {
        let lazyColide: UICollisionBehavior = UICollisionBehavior()
        lazyColide.translatesReferenceBoundsIntoBoundary = true
        return lazyColide as UICollisionBehavior
    }()
    
    lazy var dropBehavior: UIDynamicItemBehavior = {
        let lazilyBehave = UIDynamicItemBehavior()
        lazilyBehave.elasticity = 1
        return lazilyBehave
    }()
    
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(dropBehavior)
        addChildBehavior(collider)
        addChildBehavior(push)
    }
    
    func addBall(view: UIView) {
        dynamicAnimator?.referenceView?.addSubview(view)
        gravity.addItem(view)
        collider.addItem(view)
        dropBehavior.addItem(view)
    }
    struct Names {
        static let boundary = "Boundary"
    }
    func addBaddle(view: UIView){
        dynamicAnimator?.referenceView?.addSubview(view)
        collider.removeBoundaryWithIdentifier(Names.boundary)
        let origin = view.frame.origin
        let width = view.frame.width
        let rightEdge = CGPoint(x: origin.x + width, y: origin.y)
        
        collider.addBoundaryWithIdentifier(Names.boundary,
                                           fromPoint: origin ,
                                           toPoint: rightEdge)
    }
    
    func addBlock(view: UIView) {
        dynamicAnimator?.referenceView?.addSubview(view)
        collider.addItem(view)
    }
    
    func removeView(view: UIView){
        gravity.removeItem(view)
        collider.removeItem(view)
        dropBehavior.removeItem(view)
        view.removeFromSuperview()
    }
    
    
    func addBarrier(path: UIBezierPath, name: String){
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
}
