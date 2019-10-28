//
//  APShoppingViewController.swift
//  AppleNote
//
//  Created by kadis on 2019/8/20.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit

class APShoppingVC: APBaseVC {
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        let btn1 = UIButton.init(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        btn1.backgroundColor = .randomColor
        btn1.addTarget(self, action: #selector(save), for: .touchUpInside)
        self.view.addSubview(btn1)
        
        let btn2 = UIButton.init(frame: CGRect(x: 100, y: 200, width: 50, height: 50))
        btn2.backgroundColor = .randomColor
        btn2.addTarget(self, action: #selector(prints), for: .touchUpInside)
        self.view.addSubview(btn2)
        
        let btn3 = UIButton.init(frame: CGRect(x: 100, y: 300, width: 50, height: 50))
        btn3.backgroundColor = .randomColor
        btn3.addTarget(self, action: #selector(clean), for: .touchUpInside)
        self.view.addSubview(btn3)
    }
    
    @objc func save() {
        print("存储")
        setDefault(key: "aa", value: "bb" as AnyObject)
    }
    
    @objc func prints() {
        print("打印")
        print(getDefault(key: "aa") ?? "无数据")
    }
    
    @objc func clean() {
        print("清除")
        removeUserDefault(key: "aa")
    }
}
