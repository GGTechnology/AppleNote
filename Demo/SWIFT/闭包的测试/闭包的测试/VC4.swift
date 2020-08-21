//
//  VC4.swift
//  闭包的测试
//
//  Created by kadis on 2019/10/30.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

// ------------------------ 捕获 ------------------------

import UIKit

//eg.: 1
private var counter = 0
private let incrementCounter = {
    counter += 1
    print(counter)
}



class VC4: UIViewController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        /*
        由于闭包定义和变量counter在同一作用域中，
        故闭包可以捕获并访问变量counter。
        对变量counter做的任何改变，对闭包来说都是透明可见的。
        */

        incrementCounter() //1
        incrementCounter() //2
        
        /*
        该例子中，闭包捕获了封闭空间（函数实体内）的内部变量counter。
        */


        let counter1 = countingClosure()
        let counter2 = countingClosure()
        
        
        print(counter1()) // 1
        print(counter2()) // 1
        print(counter1()) // 2
        print(counter1()) // 3
        print(counter2()) // 2
    }
    
    
    
    //eg.: 2
    func countingClosure() -> () -> Int {
        var counter = 0
        let incrementCounter: () -> Int = {
            counter += 1
            return counter
        }
        return incrementCounter
    }

   


}
