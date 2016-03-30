//
//  AppDelegate.swift
//  MotionBounce
//
//  Created by abdelrahman mohamed on 3/26/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    struct Motion {
        static let Manager = CMMotionManager()
    }

}

