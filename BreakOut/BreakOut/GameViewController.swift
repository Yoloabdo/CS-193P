//
//  ViewController.swift
//  BreakOut
//
//  Created by abdelrahman mohamed on 3/19/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var gameView: UIView!
    
    var blocksPerRow = 8
    let blockBehave = BlocksBehavior()
    let baddleBehve = BaddleBehavior()
    var baddleView: UIView!

    
    var attachment: UIAttachmentBehavior? {
        willSet{
            if attachment != nil{
                animator.removeBehavior(attachment!)
            }
        }
        didSet{
            if attachment != nil{
                animator.addBehavior(attachment!)
            }
        }
    }
    
    var blockSize: CGSize {
        let size = gameView.bounds.size.width / CGFloat(blocksPerRow)
        return CGSize(width: size, height: size/2)
    }
    
    lazy var animator: UIDynamicAnimator = {
        let lazyAnimtor = UIDynamicAnimator(referenceView: self.gameView)
        return lazyAnimtor
    }()


    
    func block(x: CGFloat, y: CGFloat, color: UIColor){
        let frame = CGRect(origin: CGPoint(x: x, y: y), size: blockSize)
        let blockView = BlockView(frame: frame, color: color)
        blockBehave.addView(blockView)
    }
    
    func creatingBlocks(){
        for row in 0...10 {
            let color = UIColor.random
            for col in 0..<blocksPerRow{
                block(CGFloat(col) * blockSize.width, y: CGFloat(row) * blockSize.height, color: color)
            }
        }
    }
    
    
    func baddle(x: CGFloat = 50){
        let frame = CGRect(
            x: x,
            y: gameView.bounds.height - blockSize.height * 2,
            width: blockSize.width * 2,
            height: blockSize.height)
        baddleView = UIView(frame: frame)
        baddleView.backgroundColor = UIColor.blackColor()
        
        baddleBehve.addView(baddleView)
    }
    
    func setUpGame() {
        creatingBlocks()
        baddle()
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animator.addBehavior(blockBehave)
        animator.addBehavior(baddleBehve)
        setUpGame()
        centerBaddle = gameView.bounds.height - blockSize.height * 1.5
    }
    var centerBaddle:CGFloat?
    
    @IBAction func moveBaddle(sender: UIPanGestureRecognizer) {
        // to do
        let gesturePoint = sender.locationInView(gameView)

        switch sender.state{
        case .Began:
            attachment = UIAttachmentBehavior.slidingAttachmentWithItem(baddleView, attachmentAnchor: gesturePoint, axisOfTranslation: CGVector(dx: 0, dy: 1.0))
        case .Changed:
            attachment?.anchorPoint = gesturePoint
        case .Ended:
            attachment = nil
        default:
            break
        }

    }
}



private extension UIColor{
    class var random: UIColor {
        switch arc4random() % 7 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.redColor()
        case 2: return UIColor.blueColor()
        case 3: return UIColor.orangeColor()
        case 4: return UIColor.purpleColor()
        case 5: return UIColor.brownColor()
        case 6: return UIColor.cyanColor()
        case 7: return UIColor.yellowColor()
        default: return UIColor.whiteColor()
        }
    }
}