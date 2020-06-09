//
//  ViewController.swift
//  Swift_Block_Delegate
//
//  Created by kadis on 2020/6/5.
//  Copyright © 2020 lvguangda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, delegateViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let vD = delegateView.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100));
        vD.delegate = self
        self.view.addSubview(vD)
        
        let bD = blockView.init(frame: CGRect(x: 100, y: 300, width: 100, height: 100));
        self.view.addSubview(bD)
        
//        bD.blockproerty = {(parameter) ->() in
//            self.view.backgroundColor = .yellow
//        }
        // 可以参略写成这样
        bD.blockproerty = {(parameter) in
            self.view.backgroundColor = .yellow
        }
 
    }
    
    func btnClick(tag: Int) {
        print(tag)
        self.view.backgroundColor = .green
    }
}

