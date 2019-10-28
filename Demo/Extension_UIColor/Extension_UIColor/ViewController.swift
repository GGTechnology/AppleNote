//
//  ViewController.swift
//  Extension_UIColor
//
//  Created by kadis on 2019/9/25.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        img.backgroundColor = UIColor.init(hexString: "0x123456")
        
    }
    @IBAction func changeColor(_ sender: Any) {
        img.backgroundColor = UIColor.randomColor
    }
}

