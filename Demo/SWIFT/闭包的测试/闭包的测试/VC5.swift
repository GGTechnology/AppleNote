//
//  VC5.swift
//  闭包的测试
//
//  Created by kadis on 2019/10/30.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

// ------------------------ 捕获 ------------------------

import UIKit

var tempV5:Int = 10

class VC5: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        print(tempV5)
        var tempV5:Int = 30
        print(tempV5)
       
        // ------------------- 遍历 -------------------
        // 集合提供了很多遍历的函数用来对元素进行访问及操作，并大量应用了闭包。
        // 重点需要了解的函数有:
        // forEach、filter、map、reduce
        zSorted()
        zFiler()
        zMap()
    }
    
    // sorted
    func zSorted() {
       /*
       数组提供了一个排序函数，sorted().使用的是默认规则，当然我们也可以定制排序规则。
       */

       let names = ["ZZZZZZ", "BB", "A", "CCCC", "EEEEE", "YYY"]
       names.sorted()
       // ["A", "BB", "CCCC", "EEEEE", "ZZZZZZ"]

       //更改排序规则 其实就是利用了函数重载，具体可看函数定义
       //sorted(by: <#T##(String, String) throws -> Bool#>)

       print(names.sorted {
           $0.count > $1.count
       })
       // ["ZZZZZZ", "EEEEE", "CCCC", "BB", "A"]
    }
    
    // forEach
    func zForEach() {
        /*
        循环遍历集合中的元素，相当于for-in 快速遍历
        */

        let values = [5, 3, 2, 3,1]
        values.forEach {
            print("element is \($0)")
        }
    }
    
    // filter
    func zFiler() {
        /*
        函数原型:
         func filter(_ isIncluded: (Element) -> Bool) -> [Element]
         
         按照规则过滤原数组
        */

        var values = [1.5, 10, 4.88, 3.2, 8]

        let res = values.filter {
            return $0 > 4
        }

        //res是移除掉小于或等于4的元素的新数组
        print(res)
    }
    
    // map
    func zMap() {
        /*
        函数原型：
        students.map(<#T##transform: (String) throws -> T##(String) throws -> T#>)

        数组映射
        */

        let input = ["0", "12", "name", "hi", "3"]

        let number = input.map {
            Int($0) //将元素转换为Int型
        }
        //注意类型转换可能失败，所以返回的是可选型
        //[Optional(0), Optional(12), nil, nil, Optional(3)]

        /*
        另外一个高度近似的函数
        flatMap
        隐含了两种操作
        1.解包
        2.展开并合并
        */

        let flatNumber = input.flatMap() {
            Int($0)
        }
        //[0, 12, 3]

        print(flatNumber)
    }
    
    // reduce
    func zReduce() {
        /*
        函数原型
        reduce(<#T##initialResult: Result##Result#>, <#T##nextPartialResult: (Result, String) throws -> Result##(Result, String) throws -> Result#>)

        */

        //数组
        let flatNumber = [0, 12, 3]

        let sum = flatNumber.reduce(0) {
            return $0 + $1
        }
        //15

        //字典
        let stock = [1.5: 5, 10: 2, 4.99: 20, 2.30: 5, 8.19: 30]
        let stockSum = stock.reduce(0) {
          return $0 + $1.key * Double($1.value)
        }
        //384.5

        /*
        另一个reduce重载函数
        注意inout 关键字，所以想想你可以怎么应用？
        */
//        input.reduce(into: <#T##Result#>) { (<#inout Result#>, <#String#>) in
//            <#code#>
//        }
    }
}
