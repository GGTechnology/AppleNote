//
//  bView.swift
//  Swift_Block_Delegate
//
//  Created by kadis on 2020/6/5.
//  Copyright © 2020 lvguangda. All rights reserved.
//

        import UIKit

        class blockView: UIView {
            
            // 定义block
            typealias fucBlock = (String) -> ()
            // 创建block变量
            var blockproerty:fucBlock!

            override init(frame: CGRect) {
                super.init(frame: frame)
                
                let btn = UIButton.init(frame: self.bounds)
                btn.backgroundColor = .orange
                btn.setTitle("Block", for: .normal)
                btn.setTitleColor(.black, for: .normal)
                btn.tag = 11
                btn.addTarget(self, action: #selector(actions(_:)), for: .touchUpInside)
                self.addSubview(btn)
            }
            
            @objc func actions(_ btn:UIButton) {
                // block调用
                if let _ = blockproerty {
                    blockproerty("44")
                }
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }
