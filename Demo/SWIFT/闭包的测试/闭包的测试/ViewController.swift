//
//  ViewController.swift
//  闭包的测试
//
//  Created by kadis on 2019/10/30.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btn1: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        print("temp1 = \(tempV5)")
        tempV5 = 20;
        print("temp2 = \(tempV5)")

        // 第一次简化 类型自动推导 可以根据参数推断
        mySecondClosure = {
            (a, b) in
            return a * b
        }
        print("🍎 \(String(describing: mySecondClosure)) 🍎")

        // 第二次简化 如果函数体只包含一句 return 代码，可省略 return
        mySecondClosure = {
           (a, b) in
           a * b
        }
        
        /*
        第三次简化
        被捕获的参数列表中，含有a、b，下标从0开始，可通过"$"获取。

        编译器亦可通过，捕获列表自行推断出参数。
        故可省略参数列表 （a, b）和 关键字 in
        */
        mySecondClosure = {
            $0 * $1
        }
        
        print("str1 = \(a)")
        print("str2 = \(b)")
        print("str3 = \(c)")
        
        print("numChangeString = \(numChangeString(10))")
        
        biBaoBiaoDaShi()
    }
    
    // 闭包表达式 & 省略闭包表达式
    func biBaoBiaoDaShi() {
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        func backward(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        var reversedNames = names.sorted(by: backward)
        print("🏀 = \(reversedNames)")
        
        reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
            return s1 > s2
        })
        print("🎾 = \(reversedNames)")
        
        
        let goodName = ["a", "D", "AAA", "BB", "cccc"]
        reversedNames = goodName.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
        print("🏐️ = \(reversedNames)")
        
    }
    
    // 闭包运行赋值
    var a:String = {return "str1"}()
    // 基于闭包原理简化
    var b:String = {"str2"}()
    // 如果不需要传递实参，闭包体前的"="号，和末尾的"()"也可以省略
    var c:String {"str3"}
    
    // 尝试一个带参的闭包
    var mySecondClosure: (Int , Int ) -> Int = {
        (a: Int , b: Int) -> Int in
        return a * b
    }
    
    var numChangeString:(Int)->String = {
        (a:Int) -> String in
        return String(a)
    }
    
//    var doubleClosure:()->()->String = {
//        ()->()->String in
//        ()->String in
//        return "10"
//    }

    @IBAction func btnAction1(_ sender: Any) {
        let vc = VC2()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func VC3Action(_ sender: Any) {
        let vc = VC3()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func VC4Action(_ sender: Any) {
        let vc = VC4()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func VC5Action(_ sender: Any) {
        let vc = VC5()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

/*

 */
