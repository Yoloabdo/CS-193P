//
//  DrawingViewController.swift
//  Calculator
//
//  Created by abdelrahman mohamed on 2/13/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController, GraphViewDataSource {

    var axesDrawer: AxesDrawer?
    
  
    
    @IBOutlet weak var graphDraw: GraphView!{
        didSet{
            graphDraw.dataSource = self
        }
    }
    

    var brain = CalculatorBrain()
    
    @IBAction func zoomGraphScale(sender: UIPinchGestureRecognizer) {
        if sender.state == .Changed{
            scale *= sender.scale
            sender.scale = 1
        }

    }
    
    func scaleForGraphView(sender: GraphView) -> CGFloat {
        return scale
    }
    
    var scale: CGFloat = 50 {
        didSet{
            scale = min(max( scale, 0), 100)
            updateUI()
        }
    }
    
    func updateUI(){
        graphDraw?.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
