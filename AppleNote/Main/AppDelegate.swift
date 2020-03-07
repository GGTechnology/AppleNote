//
//  AppDelegate.swift
//  AppleNote
//
//  Created by mingcol on 2019/7/17.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // print("💙 首次进入 APP 进入前台会调用，优先级 1")
        
        // Override point for customization after application launch.
        
        Bugly.start(withAppId: "28fc2f286b")

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ANTabBarController()
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
         
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        return true
    }

    // 前台进入后台
    func applicationWillResignActive(_ application: UIApplication) {
        // print("❤️ 每次前台进入后台调用，优先级 1")
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        // print("🧡 每次前台进入后台调用，优先级 2")
    }
    // 后台进入前台
    func applicationWillEnterForeground(_ application: UIApplication) {
        // print("💛 后台进入前台调用，优先级 1")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // 1: 首次进入 APP 进入前台成功会调用(如果进入前台立刻 Crash，则不会调用)，优先级
        // 2: 后台进入前台调用，优先级 2
        // print("🤎")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("💚 KILL APP")
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        print("💜 应用处于后台，所有下载任务完成调用，handleEventsForBackgroundURLSession")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        UIApplication.shared.beginBackgroundTask {
            
        }
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        //iPhone设备只有有限的内存，如果为应用程序分配了太多内存操作系统会终止应用程序的运行，在终止前会执行这个方法，通常可以在这里进行内存清理工作防止程序被终止
    }
    func applicationSignificantTimeChange(_ application: UIApplication) {
        // 当系统时间发生改变时执行
    }
    func application(_ application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
        // 当StatusBar框将要变化时执行
    }
    func application(_ application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        // 当StatusBar框方向将要变化时执行
    }
    func application(_ application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
        //    说明：当StatusBar框方向变化完成后执行
    }
    func application(_ application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect) {
        //    说明：当StatusBar框变化完成后执行
    }


    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // 当一个运行着的应用程序收到一个远程的通知 发送到委托去...7.0之后
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 当一个应用程序成功的注册一个推送服务（APS） 发送到委托去...
    }
    func application(_ application:
        UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // 当 APS无法成功的完成向 程序进程推送时 发送到委托去..
    }
    
//    appDidEnterBackgroundNotif
//    appdidenterfackg
    
}

