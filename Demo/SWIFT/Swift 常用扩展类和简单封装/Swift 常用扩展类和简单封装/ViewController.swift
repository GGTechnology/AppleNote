//
//  ViewController.swift
//  Swift 常用扩展类和简单封装
//
//  Created by kadis on 2020/6/6.
//  Copyright © 2020 lvguangda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var l4: UILabel!
    @IBOutlet weak var l5: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        l1.text = "扩展UIColor 生成随机颜色"
        l1.backgroundColor = .randomColor

        l2.text = "将16进制颜色转换为RGB"
        l2.backgroundColor = UIColor(hexString: "EFDDBD")

        let guesture = UITapGestureRecognizer(target:self,action:#selector(self.singleTap(_ :)))
        // 写成下面这样也没事
        // let guesture1 = UITapGestureRecognizer(target:self,action:#selector(self.singleTap))
        guesture.gestureTag = 99
        l4.text = "点击屏幕给手势添加的tag"
        l4.backgroundColor = .randomColor
        self.view.addGestureRecognizer(guesture)
        
        l5.text = "abc惊醒md5加密的结果：\("abc".getMD5())"
        l5.backgroundColor = .randomColor
        
        let btn = UIButton.init(frame: CGRect(x: 100, y: 150, width: 50, height: 50))
        btn.addTarget(self, action: #selector(aa), for: .touchUpInside)
        btn.backgroundColor = .black
        self.view.addSubview(btn)
        l2.isHidden = true
        
        let nowVC = UIViewController.currentViewController(base: self)
        let nowV = UIView.init(frame: CGRect(x: 100, y: 150, width: 50, height: 50))
        nowV.backgroundColor = .red
        nowVC?.view.addSubview(nowV)
        l3.text = "\(String(describing: UIViewController.currentViewController(base: self)))"
    }
    
    @objc func aa() {
        self .present(vc1(), animated: true, completion: nil)
    }
    
    @objc func singleTap(_ guseture:UITapGestureRecognizer) {
        l4.text = "给手势添加的tag = \(guseture.gestureTag!)"
    }
}

