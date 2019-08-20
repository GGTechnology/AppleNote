//
//  ANTabBarControll.swift
//  AppleNote
//
//  Created by kadis on 2019/8/16.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit

class ANTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
}
