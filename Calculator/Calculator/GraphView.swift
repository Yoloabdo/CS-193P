//
//  GraphView.swift
//  Calculator
//
//  Created by abdelrahman mohamed on 2/14/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

protocol GraphViewDataSource:class{
    func scaleForGraphView(sender: GraphView) -> CGFloat
    var origin:CGPoint? { get }
    func y(x: CGFloat) -> CGFloat?
}

@IBDesignable
class GraphView: UIView {

    weak var dataSource: GraphViewDataSource?


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
    
    @IBInspectable
    var lineWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() } }

    
    
    var origin = CGPoint() {
        didSet{
            setNeedsDisplay()
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
        
        scale = dataSource?.scaleForGraphView(self) ?? 50
        origin = dataSource?.origin ?? center
        AxesDrawer(color: color, contentScaleFactor: scale).drawAxesInRect(bounds, origin: origin, pointsPerUnit: scale)
        
       
        drawFunc()
    }
    
    ///Draws what ever lay there in the last parameter in calculator brain
    ///goes through each pixel to draw it in the view.
    ///Returns none.
    func drawFunc(){
        color.set()
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        var firstValue = true
        var point = CGPoint()
        for var i = 0; i <= Int(bounds.size.width * contentScaleFactor); i++ {
            point.x = CGFloat(i) / contentScaleFactor
            if let y = dataSource?.y((point.x - origin.x) / scale) {
                if !y.isNormal && !y.isZero {
                    firstValue = true
                    continue
                }
                point.y = origin.y - y * scale
                if firstValue {
                    path.moveToPoint(point)
                    firstValue = false
                } else {
                    path.addLineToPoint(point)
                }
            } else {
                firstValue = true
            }
        }
        path.stroke()
    }


}
