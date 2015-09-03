//
//  AppDelegate.swift
//  GoogleMapsAnimationGlitch
//
//  Created by Gilad Gurantz on 8/8/15.
//  Copyright (c) 2015 Lazy Arcade. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyC1dNFV-q5w5OearYdBlXTCtG2ajYxYomg")

        // Override point for customization after application launch.
        return true
    }
}

