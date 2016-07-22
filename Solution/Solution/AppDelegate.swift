//
//  AppDelegate.swift
//  Solution
//
//  Created by Nick Adcock on 7/19/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarController: SolutionTabViewController?
    let stack = CoreDataStack.stack
    let context = CoreDataStack.stack.context

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        stack.autoSave(5)
        
        // uncomment this to clear out database data on load
//        do{
//            try stack.dropAllData()
//        }catch{
//            fatalError("Error while saving backgroundContext: \(error)")
//        }
        
        tabBarController = SolutionTabViewController()
        let firstVC = UserNavigationController()
        let secondVC = AlbumNavigationController()
        
        firstVC.title = "Users"
        secondVC.title = "Photos"
        
        tabBarController?.viewControllers = [firstVC, secondVC]
        
        let tabBar = tabBarController?.tabBar
        
        let userImage: UIImage! = UIImage(named: "userIcon")!.imageWithRenderingMode(.AlwaysOriginal)
        let photoImage: UIImage! = UIImage(named: "photoIcon")!.imageWithRenderingMode(.AlwaysOriginal)
        
        let userSelectedImage: UIImage! = UIImage(named: "userIcon")!.imageWithRenderingMode(.AlwaysTemplate)
        let photoSelectedImage: UIImage! = UIImage(named: "photoIcon")!.imageWithRenderingMode(.AlwaysTemplate)
        
        (tabBar!.items![0]).image = userImage
        (tabBar!.items![1]).image = photoImage
        (tabBar!.items![0]).selectedImage = userSelectedImage
        (tabBar!.items![1]).selectedImage = photoSelectedImage
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = tabBarController
        self.window!.backgroundColor = UIColor.whiteColor()
        application.statusBarHidden = true
        self.window!.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

