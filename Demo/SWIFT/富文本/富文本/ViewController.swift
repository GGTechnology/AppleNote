//
//  ViewController.swift
//  富文本
//
//  Created by LvGuangDa on 2019/9/22.
//  Copyright © 2019 shijunnian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let a = UILabel(frame: CGRect(x: 50, y: 100, width: 300, height: 15))
        self.view.addSubview(a)
        
        let attrStr = NSMutableAttributedString.init(string: "01 周五")
        attrStr.addAttribute(NSAttributedString.Key.font, value:UIFont.systemFont(ofSize: 10), range:NSRange.init(location:3, length: 2))
        a.attributedText = attrStr
        
    }

   

}

