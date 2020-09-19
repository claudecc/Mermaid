//
//  AppDelegate.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2018/3/19.
//  Copyright © 2018年 蔡晓东. All rights reserved.
//

import UIKit
import EchoSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    public class func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = BaseVC()
        self.window?.makeKeyAndVisible()
        self.checkLogin()

        UIButton.appearance().isExclusiveTouch = false
        
        // Echo是一款客户端的桌面端调试工具
        #if DEBUG
        ECOClient.shared()?.start()
        #endif
        
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

    func checkLogin() {
        if MyTool.isLogin() {
            self.setupSystem()
        } else {
            self.gotoLogin()
        }
    }
    
    func gotoLogin() {
        let currentVC = MyTool.topViewController()
        if currentVC?.isKind(of: LoginVC.self) == true {
            return
        }
        self.window?.rootViewController = LoginVC()
    }
    
    func setupSystem() {
        self.window?.rootViewController = BaseTabbarVC()
    }
    
}

