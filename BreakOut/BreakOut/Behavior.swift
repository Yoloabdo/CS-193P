//
//  HitBallBehavior.swift
//  BreakOut
//
//  Created by abdelrahman mohamed on 3/20/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class Behavior: UIDynamicBehavior, UICollisionBehaviorDelegate {
    
//    all behaviors should be declared here, the varient is in adding the selected views to which behavior.
    

    
    lazy var push: UIPushBehavior = {
        let lazyPushBehavior = UIPushBehavior(items: [], mode: UIPushBehaviorMode.Instantaneous)
        lazyPushBehavior.pushDirection = CGVectorMake(0.1, 0.5)
        lazyPushBehavior.active = true
        return lazyPushBehavior
        
    }()
    
    lazy var collider: UICollisionBehavior = {
        let lazyColide: UICollisionBehavior = UICollisionBehavior()
        lazyColide.translatesReferenceBoundsIntoBoundary = true
        lazyColide.collisionDelegate = self
        lazyColide.collisionMode = .Everything
        lazyColide.action = {
            
        }
        return lazyColide as UICollisionBehavior
    }()
    
    lazy var dropBehavior: UIDynamicItemBehavior = {
        let lazilyCreatedBallBehavior = UIDynamicItemBehavior()
        lazilyCreatedBallBehavior.allowsRotation = true
        lazilyCreatedBallBehavior.elasticity = 0.98
        lazilyCreatedBallBehavior.friction = 0
        lazilyCreatedBallBehavior.resistance = 0
        return lazilyCreatedBallBehavior
    }()
    
    
    override init() {
        super.init()
        addChildBehavior(dropBehavior)
        addChildBehavior(collider)
        addChildBehavior(push)
    }
    
    func addBall(view: UIView) {
        dynamicAnimator?.referenceView?.addSubview(view)
        collider.addItem(view)
        dropBehavior.addItem(view)
        push.addItem(view)
        
    }
    
    struct Constants {
        static let boundary = "Boundary"
        static let radius: CGFloat = 1
    }
    
    func addPaddle(view: UIView){
        dynamicAnimator?.referenceView?.addSubview(view)
        collider.removeBoundaryWithIdentifier(Constants.boundary)
        let path = UIBezierPath(roundedRect: view.frame, cornerRadius: Constants.radius)
        collider.addBoundaryWithIdentifier(Constants.boundary,forPath: path)
    }
    
    func addBlock(view: BlockView) {
        dynamicAnimator?.referenceView?.addSubview(view)
        collider.removeBoundaryWithIdentifier("\(view.index)")
        let path = UIBezierPath(roundedRect: view.frame, cornerRadius: Constants.radius)
        collider.addBoundaryWithIdentifier("\(view.index)",forPath: path)
        blocks.append(view)
    }
    
    var blocks = [BlockView]()
    
    
    func removeView(view: UIView){
        collider.removeItem(view)
        dropBehavior.removeItem(view)
        view.removeFromSuperview()
    }
    
    
    func addBarrier(path: UIBezierPath, name: String){
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    
    func removeBlock(identifier: Int){
        collider.removeBoundaryWithIdentifier("\(identifier)")
        let view = blocks[identifier]
        removeView(view)
        
    }
    
    
    func pushBall(ball: UIView) {
        let push = UIPushBehavior(items: [ball], mode: .Instantaneous)
        push.magnitude = 1.0
        
        push.angle = CGFloat(Double(arc4random()) * M_PI * 2 / Double(UINT32_MAX))
        push.action = { [weak push] in
            if !push!.active {
                self.removeChildBehavior(push!)
            }
        }
        addChildBehavior(push)
    }
    
    
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        
        if let id = identifier, let index = Int(id as! String) {
            removeBlock(index)
        }
    }
}
