//
//  AppDelegate.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/16/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var user: MusicUser!
//    var mask: CALayer?
//    var imageView: UIImageView?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//
//        let imageView = UIImageView(frame: self.window!.frame)
//        imageView.image = UIImage(named: "appscreenshot")
//        self.window!.addSubview(imageView)
//        self.mask = CALayer()
//        self.mask!.contents = UIImage(named: "NewMusicLogoWhite")!.cgImage
//        self.mask!.contentsGravity = CALayerContentsGravity.resizeAspect
//        self.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
//        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        self.mask!.position = CGPoint(x: imageView.frame.size.width/2, y: imageView.frame.size.height/2)
//
//        // Starting from Xcode7, iOS9 requires all UIWindow must have a rootViewController
//        let emptyView = UIViewController()
//        self.window?.rootViewController = emptyView
//
//        imageView.layer.mask = mask
//        self.imageView = imageView
//
//        animateMask()
//
//        // Override point for customization after application launch.
//        self.window!.backgroundColor = UIColor.rgb(red: 6, green: 28, blue: 61)
//        self.window!.makeKeyAndVisible()
    
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = BaseSlidingVC()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    func animateMask() {
//        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
//        keyFrameAnimation.delegate = self as? CAAnimationDelegate
//        keyFrameAnimation.duration = 1
//        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1 //add delay of 1 second
//        let initalBounds = NSValue(cgRect: mask!.bounds)
//        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 90, height: 90))
//        let finalBounds = NSValue(cgRect: CGRect(x: -100, y: -100, width: 2500, height: 2500))
//        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
//        keyFrameAnimation.keyTimes = [0, 0.3, 1]
//        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut), CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
//        self.mask!.add(keyFrameAnimation, forKey: "bounds")
//    }

}

