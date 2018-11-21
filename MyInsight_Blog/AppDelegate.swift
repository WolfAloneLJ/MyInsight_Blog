//
//  AppDelegate.swift
//  MyInsight_Blog
//
//  Created by SongMengLong on 2018/11/19.
//  Copyright © 2018 SongMengLong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 设置3D Touch
        setup3DTouch()
        
        // 判断应用是否是第一次启动
        isRightFirstLaunched()
        
        return true
    }
    
    
    //MARK: - 判断是否为首次启动
    func isRightFirstLaunched() -> Void {
        /*
         若是第一次加载，进入欢迎页面，若不是直接进入主页面
         */
        let userDefaults: UserDefaults = UserDefaults.standard;
        debugPrint("是不是第一次启动")
        
        if (userDefaults.string(forKey: "LauchAgree") == nil) {
            userDefaults.set(true, forKey: "LauchAgree")
            debugPrint("首次启动 进入欢迎页面")
            
            let welcomeVC: WelcomeVC = WelcomeVC()
            self.window?.rootViewController = welcomeVC
        } else {
            debugPrint("不是首次启动 进入主页面")
            let tabBarVC: TabBarVC = TabBarVC()
            self.window?.rootViewController = tabBarVC
        }
    }
    
    func setup3DTouch() {
        debugPrint("你说是啥就是啥")
        // Swift开发之3DTouch实用演练 http://www.sohu.com/a/200417763_208051
        let homeIcon = UIApplicationShortcutIcon(type: UIApplicationShortcutIcon.IconType.compose)
        let homeItem = UIApplicationShortcutItem(type: "homeAnchor", localizedTitle: "首页", localizedSubtitle: "点击进入首页", icon: homeIcon, userInfo: nil)
        
        let playIcon = UIApplicationShortcutIcon(type: UIApplicationShortcutIcon.IconType.play)
        let playItem = UIApplicationShortcutItem(type: "homeAnchor", localizedTitle: "播放", localizedSubtitle: "开始点播了", icon: playIcon, userInfo: nil)
        
        let userIcon = UIApplicationShortcutIcon(type: UIApplicationShortcutIcon.IconType.search)
        let userItem = UIApplicationShortcutItem(type: "homeAnchor", localizedTitle: "用户名", localizedSubtitle: "你爸爸是谁", icon: userIcon, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [homeItem, playItem, userItem]
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


}

