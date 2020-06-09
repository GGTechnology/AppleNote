//
//  vc1.swift
//  Swift 常用扩展类和简单封装
//
//  Created by kadis on 2020/6/6.
//  Copyright © 2020 lvguangda. All rights reserved.
//

import UIKit

class vc1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        // Do any additional setup after loading the view.
        
        print(UIViewController.currentViewController())
        print(UIViewController.currentViewController(base: self))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
