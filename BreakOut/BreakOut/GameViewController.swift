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
    let dynamicBehavior = Behavior()

    
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
        dynamicBehavior.addBlock(blockView)
    }
    
    func creatingBlocks(){
        for row in 0...10 {
            let color = UIColor.random
            for col in 0..<blocksPerRow{
                block(CGFloat(col) * blockSize.width, y: CGFloat(row) * blockSize.height, color: color)
            }
        }
    }
    
    
    lazy var ball: UIView = {
        let ballview = BallView(frame: CGRect(origin: CGPoint(x: 59, y: self.gameView.bounds.midY) , size: CGSize(width: 25, height: 25)))
        ballview.backgroundColor = UIColor.blueColor()
        ballview.layer.cornerRadius = 10
        self.dynamicBehavior.addBall(ballview)
        return ballview
    }()
    
    lazy var baddle: UIView = {
        [unowned self ] in
        let frame = CGRect(
            x: 50,
            y: self.gameView.bounds.height - self.blockSize.height * 2,
            width: self.blockSize.width * 2,
            height: self.blockSize.height)
        let baddleView = UIView(frame: frame)
        baddleView.backgroundColor = UIColor.blackColor()
        
        self.dynamicBehavior.addBaddle(baddleView)
        return baddleView
    }()
    
    
    func setUpGame() {
        creatingBlocks()
        ball.setNeedsDisplay()
        baddle.setNeedsDisplay()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animator.addBehavior(dynamicBehavior)
        setUpGame()
        
       
        
    }
    
    
    
    @IBAction func moveBaddle(sender: UIPanGestureRecognizer) {
        let gesturePoint = sender.locationInView(gameView)

        switch sender.state{
        case .Began:
            attachment = UIAttachmentBehavior.slidingAttachmentWithItem(baddle, attachmentAnchor: gesturePoint, axisOfTranslation: CGVector(dx: 0, dy: 1.0))
            attachment?.action = {
                [unowned self] in
                self.dynamicBehavior.addBaddle(self.baddle)
            }
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