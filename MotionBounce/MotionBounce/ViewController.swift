//
//  ViewController.swift
//  MotionBounce
//
//  Created by abdelrahman mohamed on 3/26/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var masterView: UIView!
    
    let bouncer = BouncerBehavior()
    lazy var animator:UIDynamicAnimator = {UIDynamicAnimator(referenceView: self.masterView)}()
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(bouncer)
        
    }
    
    var redBlock: UIView?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if redBlock == nil {
            redBlock = addBlock()
            redBlock?.backgroundColor = UIColor.redColor()
            bouncer.addView(redBlock!)
        }
        
        let motionManager = AppDelegate.Motion.Manager
        if motionManager.accelerometerAvailable {
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()){
                (data, error ) in
                self.bouncer.gravity.gravityDirection = CGVector(dx: (data?.acceleration.x)!,
                                                                 dy: -(data?.acceleration.y)!)
            }
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.Motion.Manager.stopAccelerometerUpdates()
    }
    struct Constants {
        static let blockSize = CGSize(width: 40, height: 40)
    }
    
    func addBlock() -> UIView {
        let block = UIView (frame: CGRect(origin: CGPointZero, size: Constants.blockSize))
        block.center = CGPoint(x: masterView.bounds.midX, y: masterView.bounds.midY)
        view.addSubview(block)
        return block
    }

}

