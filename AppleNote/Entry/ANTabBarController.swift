//
//  ANTabBarControll.swift
//  AppleNote
//
//  Created by kadis on 2019/8/16.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit

class ANTabBarController: UITabBarController {
    
    var shutoutView:UIView!
    var type:NSInteger!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        shutoutView = UIView(frame: self.view.bounds)
        //        shutoutView.backgroundColor = .cyan
        //        self.view.addSubview(shutoutView)

//        let viewMain = APNoteVC()
//        viewMain.title = "日记"
//
//        let viewSetting = APShoppingVC()
//        viewSetting.title = "设置"
        
        let main = ANNavigationController(rootViewController: APNoteVC())
        main.tabBarItem.image = UIImage(named:"")
        main.tabBarItem.title = "日记"
        
        //  定义 tab 按钮添加个 badge 小红点
        main.tabBarItem.badgeValue = "!"
        
        
        let setting = ANNavigationController(rootViewController: APShoppingVC())
        setting.tabBarItem.image = UIImage(named:"")
        setting.tabBarItem.title = "设置"
        
        self.viewControllers = [main, setting]
        
        // 默认选中的是游戏主界面视图
        self.selectedIndex = 0
        
        let a:String! = name(a: "name")
        print("🍎 = ", a!);
        
        
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            if error != nil {
                type = 1
                print("type = ", type!)
            }
            if #available(iOS 11.0, *) {
                print("#available(iOS 11.0, *)")
            }
            if context.biometryType == .faceID {
                type = 2
                print("type = ", type!)
            } else {
                type = 3
                print("type = ", type!)
            }
        } else {
            type = 1
            print("type = ", type!)
            testInput()
        }
    }
    
    func testInput() {
        let alertView = UIAlertView(title: "", message: "请输入密码", delegate: nil, cancelButtonTitle: "确定", otherButtonTitles: "取消")
        alertView.alertViewStyle = .secureTextInput
        alertView.show()

    }
    func name(a:String!) -> String {
        return "test"
    }
    
    
}
