//
//  VC2.swift
//  闭包的测试
//
//  Created by kadis on 2019/10/30.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

import UIKit

class VC2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        
        print(myClosure())

        noData()
        let a = noData()
    }

    //无返回值的闭包
    var noData:() -> Void = {
        print("空闭包")
    }
    
    //有返回值的闭包
    var myClosure: () -> String = {
        return "hello world"
    }

    
}
