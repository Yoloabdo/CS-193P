//
//  DrawingViewController.swift
//  Calculator
//
//  Created by abdelrahman mohamed on 2/13/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController, GraphViewDataSource {

    
    var scale: CGFloat = 50 {
        didSet{
            scale = min(max( scale, 0), 100)
            updateUI()
        }
    }
    
    var origin: CGPoint? {
        didSet{
            updateUI()
        }
    }
  
    
    @IBOutlet weak var graphDraw: GraphView!{
        didSet{
            graphDraw.dataSource = self
        }
    }
    @IBAction func tapCenter(sender: UITapGestureRecognizer) {
        if sender.state == .Ended{
            origin = sender.locationInView(graphDraw)
        }
    }
    

    private var brain = CalculatorBrain()
    
    @IBAction func zoomGraphScale(sender: UIPinchGestureRecognizer) {
        if sender.state == .Changed{
            scale *= sender.scale
            sender.scale = 1
        }

    }
    
    @IBAction func movingCenter(sender: AnyObject) {
        if sender.state == .Changed{
            origin = sender.locationInView(graphDraw)
        }
        
    }
    
    func scaleForGraphView(sender: GraphView) -> CGFloat {
        return scale
    }

    
    func updateUI(){
        graphDraw?.setNeedsDisplay()
    }
    
    func y(x: CGFloat) -> CGFloat? {
        brain.variableValues["M"] = Double(x)
        if let y = brain.evaluate() {
            return CGFloat(y)
        }
        return nil
    }
    
    typealias PropertyList = AnyObject
    
    var program: PropertyList {
        get {
            return brain.program
        }
        set {
            brain.program = newValue
        }
    }
    


}
