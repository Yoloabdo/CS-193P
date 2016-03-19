//
//  AppDelegate.swift
//  Trx
//
//  Created by abdelrahman mohamed on 3/14/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class GPXURL {
    static let notification = "GPXURL notification Station"
    static let key = "GPXURL KEY"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        
        let center = NSNotificationCenter.defaultCenter()
        let notification = NSNotification(name: GPXURL.notification, object: self, userInfo: [GPXURL.key:url])
        center.postNotification(notification)
        return true
    }

}

