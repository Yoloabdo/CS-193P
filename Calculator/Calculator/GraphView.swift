//
//  GraphView.swift
//  Calculator
//
//  Created by abdelrahman mohamed on 2/14/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {

    @IBInspectable
    var color = UIColor.blackColor(){
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var scale: CGFloat = 50.0 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    var origin = CGPoint() {
        didSet{
            resetOrigins = false
            setNeedsDisplay()
        }
    }
    
    var resetOrigins = true{
        didSet{
            if resetOrigins{
                setNeedsDisplay()
            }
        }
    }
    
    override var center:CGPoint{
        didSet{
            origin = center
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if resetOrigins{
            origin = center
        }
        
        AxesDrawer(color: color, contentScaleFactor: scale).drawAxesInRect(bounds, origin: origin, pointsPerUnit: scale)
        
    }
    

}
