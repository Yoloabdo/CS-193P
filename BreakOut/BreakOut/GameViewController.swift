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
    
    var blockSize: CGSize {
        let size = gameView.bounds.size.width / CGFloat(blocksPerRow)
        return CGSize(width: size, height: size/2)
    }

    func block(x: CGFloat, y: CGFloat, color: UIColor){
        let frame = CGRect(origin: CGPoint(x: x, y: y), size: blockSize)
        let blockView = UIView(frame: frame)
        blockView.backgroundColor = color
        blockView.layer.borderColor = UIColor.blackColor().CGColor
        blockView.layer.borderWidth = 1.0
        
        gameView.addSubview(blockView)
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
        let baddleView = UIView(frame: frame)
        baddleView.backgroundColor = UIColor.blackColor()
        baddleView.layer.borderColor = UIColor.redColor().CGColor
        gameView.addSubview(baddleView)
    }
    
    func setUpGame() {
        creatingBlocks()
        baddle()
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
     
        setUpGame()
    }
    @IBAction func moveBaddle(sender: UIPanGestureRecognizer) {
        // to do
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