//
//  ViewController.swift
//  BreakOut
//
//  Created by abdelrahman mohamed on 3/19/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    // MARK:- Outlets 
    
    @IBOutlet weak var gameView: UIView!
    
    // MARK:- Vars and closures 
    
    var blocksPerRow = 8
    let dynamicBehavior = Behavior()
    var startingGame = true
    var label: UILabel?


    lazy var animator: UIDynamicAnimator = {
        let lazyAnimtor = UIDynamicAnimator(referenceView: self.gameView)
        return lazyAnimtor
    }()
    
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
    
    lazy var ball: UIView = {
        var pos = CGPoint(x: 50, y: self.gameView.bounds.height - self.blockSize.height * 2 - 25)
        let ballview = BallView(frame: CGRect(origin: pos , size: CGSize(width: 25, height: 25)))
        
        return ballview
    }()
    
    lazy var paddle: UIView = {
        [unowned self ] in
        let frame = CGRect(
            x: 50,
            y: self.gameView.bounds.height - self.blockSize.height * 2,
            width: self.blockSize.width * 2,
            height: self.blockSize.height)
        let paddleView = UIView(frame: frame)
        paddleView.backgroundColor = UIColor.blackColor()
        return paddleView
        }()
    

    // MARK:- View helper functions 
    
    // drawing block func
    func block(x: CGFloat, y: CGFloat, color: UIColor, index: Int) -> BlockView {
        let frame = CGRect(origin: CGPoint(x: x, y: y), size: blockSize)
        let blockView = BlockView(frame: frame, color: color, index: index)
        dynamicBehavior.addBlock(blockView)
        return blockView
    }
    
    // iterating to bulid blocks
    func creatingBlocks(){
        var count = 0
        for row in 0...10 {
            let color = UIColor.random
            for col in 0..<blocksPerRow{
                block(CGFloat(col) * blockSize.width, y: CGFloat(row) * blockSize.height, color: color, index: count)
                count += 1
                
            }
        }
    }
    
    
    
    
   
    //MARK:- gesture actions
    
    @IBAction func pushTap(sender: UITapGestureRecognizer) {
        
        
        switch  sender.state {
        case .Ended:
            fallthrough
        case .Changed:
            // starting game behavior
            if startingGame {
                self.dynamicBehavior.addPaddle(paddle)
                self.dynamicBehavior.addBall(ball)
                startingGame = false
                label?.removeFromSuperview()
            }
            // pushingBehavior
            dynamicBehavior.pushBall(ball)
        default:
            break
        }

    }
    
    
    @IBAction func movePaddle(sender: UIPanGestureRecognizer) {
        let gesturePoint = sender.locationInView(gameView)

        if !startingGame {
            switch sender.state{
            case .Began:
                attachment = UIAttachmentBehavior.slidingAttachmentWithItem(paddle, attachmentAnchor: gesturePoint, axisOfTranslation: CGVector(dx: 0, dy: 1.0))
                attachment?.action = {
                    [unowned self] in
                    self.dynamicBehavior.addPaddle(self.paddle)
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
    
    
    // MARK:- launching functions
    
    func setUpGame() {
        creatingBlocks()
        ball.setNeedsDisplay()
        paddle.setNeedsDisplay()
        startingGameText()
        
    }
    
    func startingGameText() {
        let size = CGSize(width: gameView.bounds.width, height: gameView.bounds.height / 4)
        label = UILabel(frame: CGRect(origin: CGPoint(x: gameView.bounds.minX, y: gameView.bounds.midY), size: size))
        label!.text = "Tab to start The game!"
        label?.textAlignment = .Center
        gameView.addSubview(label!)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animator.addBehavior(dynamicBehavior)
        setUpGame()
        
    }
    
}

// MARK:- Extinsions 

private extension UIColor{
    class var random: UIColor {
        switch arc4random() % 8 {
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