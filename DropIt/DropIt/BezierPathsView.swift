//
//  BezierPathsView.swift
//  DropIt
//
//  Created by abdelrahman mohamed on 3/3/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class BezierPathsView: UIView {

  
    private var bezierPaths = [String: UIBezierPath]()
    
    func setPath(path: UIBezierPath?, name: String){
        bezierPaths[name] = path
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        for (_, path) in bezierPaths {
            path.stroke()
        }
    }
}
