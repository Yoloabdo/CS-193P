//
//  ViewController.swift
//  DropIt
//
//  Created by abdelrahman mohamed on 3/1/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController {

    @IBOutlet weak var viewGame: BezierPathsView!
  
    
    lazy var animator: UIDynamicAnimator = {
        let lazyAnimtor = UIDynamicAnimator(referenceView: self.viewGame)
        return lazyAnimtor
    }()
    
    var dropitBehav = DropItBehavior()
    
    var dropsPerRow = 10
    var dropSize: CGSize {
        var size = viewGame.bounds.size.width / CGFloat(dropsPerRow)
        size += CGFloat.random(20)
        return CGSize(width: size, height: size)
    }
   
    
    @IBAction func drop(sender: UITapGestureRecognizer) {
        drop()
    }
    
    func addPathBarrier(x: CGFloat, y : CGFloat, name: String){
        let size = viewGame.bounds.size.width / CGFloat(10)
        let barrierSize = CGSize(width: size, height: size)
        let barrierOrigin = CGPoint(x: x - barrierSize.width/2 , y: y - barrierSize.height/2)
        let path = UIBezierPath(ovalInRect: CGRect(origin: barrierOrigin, size: barrierSize))
        dropitBehav.addBarrier(path, name: name)
        viewGame.setPath(path, name: name)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator.addBehavior(dropitBehav)
    }
    
    private struct PathStory {
        static let barrierName = "centerBarrier"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
     
//        addPathBarrier(viewGame.bounds.midX * 1.5 , y: viewGame.bounds.midX, name: "first")
//        addPathBarrier(viewGame.bounds.midX/2, y: viewGame.bounds.midX, name: "third")
        addPathBarrier(viewGame.bounds.midX, y: viewGame.bounds.midY, name: PathStory.barrierName)
    }
    
    func drop() {
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.random
        
        viewGame.addSubview(dropView)
        
        dropitBehav.addDrop(dropView)
    }
}


private extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

private extension UIColor{
    class var random: UIColor {
        switch arc4random() % 5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.redColor()
        case 2: return UIColor.blueColor()
        case 3: return UIColor.orangeColor()
        case 4: return UIColor.purpleColor()
        default: return UIColor.blackColor()
        }
    }
}