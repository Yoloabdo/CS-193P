//
//  ViewController.swift
//  Smiliness
//
//  Created by abdelrahman mohamed on 2/1/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, faceViewDataSource {

    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
   
    var happiness:Int = 100 {
        didSet{
            happiness = min(max( happiness, 0), 100)
            updateUI()
        }
    }
    
    func updateUI(){
        faceView.setNeedsDisplay()
    }
    struct Constants {
        static let HappinessGestureScale: CGFloat = 4.0
    }
    @IBAction func changeHappiness(sender: UIPanGestureRecognizer) {
        switch sender.state{
        case .Ended:
            fallthrough
        case .Changed:
            let translation = sender.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0{
                happiness += happinessChange
                sender.setTranslation(CGPointZero, inView: faceView)
            }
        default:
            break
        }
    }
    @IBAction func quickSmile(sender: UITapGestureRecognizer) {
        switch sender.state{
        case .Ended:
            fallthrough
        case .Changed:
            if happiness < 50{
                happiness = 100
            }else{
                happiness = 0
            }
        default:
            break
        }
        
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }

}

