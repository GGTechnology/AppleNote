//
//  dView.swift
//  Swift_Block_Delegate
//
//  Created by kadis on 2020/6/5.
//  Copyright © 2020 lvguangda. All rights reserved.
//

        import UIKit

        //声明代理协议
        protocol delegateViewDelegate {
            //代理方法
            func btnClick(tag:Int)
        }

        class delegateView: UIView {
            
            public var delegate:delegateViewDelegate?
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                
                let btn = UIButton.init(frame: self.bounds)
                btn.backgroundColor = .cyan
                btn.tag = 10
                btn.setTitle("Delegate", for: .normal)
                btn.setTitleColor(.black, for: .normal)
                btn.addTarget(self, action: #selector(actions(_:)), for: .touchUpInside)
                self.addSubview(btn)
            }
            
            @objc func actions(_ btn:UIButton) {
                if (delegate != nil) {
                    delegate?.btnClick(tag: btn.tag)
                }
            }

            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }
