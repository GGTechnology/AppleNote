//
//  VC3.swift
//  闭包的测试
//
//  Created by kadis on 2019/10/30.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

import UIKit

class VC3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        //实现一个闭包
        let multipyClosure:(Int, Int) -> Int = {
            $0 * $1
        }
        
        //等同于
        let multipyClosures = {
            (a: Int, b: Int) in
            a * b
        }
        
        //下面，我们将闭包作为参数传递
        print(myOpreation(4, 2, operation:multipyClosure))
        
        //展开 inline
        print(myOpreation(4, 2, operation: {
                   (a: Int, b: Int) -> Int in
                   return a * b
               }))
       
        /*
        事实上，我们并没有必要在本地定义一个闭包常量或变量，再作为参数传递。
        可以简单的在调用的地方进行声明并简化
        */
        print(myOpreation(4, 2, operation:{
            $0 * $1
        }))
        
        //进一步简化，* 操作符是一个有两个参数并返回一个结果的函数。可做如下简化:
        print(myOpreation(4, 2, operation: *))

        /*
        如果闭包是作为函数的最后一个参数，可以将闭包后置到函数体外部。
        */
        print(myOpreation(4, 2) {
            $0 * $1
        })
    }
    

   /*
    operation: 是一个闭包类型的参数
    该闭包有两个参数（Int, Int） ,并有一个Int型返回值

    要整体看待，不要蒙圈。
    */
    func myOpreation(_ a: Int , _ b: Int, operation: (Int , Int) -> Int) -> Int {
        let res = operation(a, b)
        return res
    }

}
