//
//  APTableView.swift
//  AppleNote
//
//  Created by kadis on 2019/10/29.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit

@objc protocol APTableViewDelegate:NSObjectProtocol {
    @objc optional func endRreshData (refreshStatu:Bool, Data:Array<Any>)
}

class APTableView: UITableView {
    
    weak var delegateObj: APTableViewDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 是否有头部刷新
    var isHR: Bool? {
        set {
            if newValue! {
                self.spr_setIndicatorHeader {
                    self.requestNetwork()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.spr_endRefreshing()
                    }
                }
            }
        }
        get {
            return false
        }
    }
    // 是否有脚部刷新
    var isFR: Bool? {
        set {
            if newValue! {
                self.spr_setIndicatorFooter {
                    self.requestNetwork()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.spr_endRefreshing()
                    }
                }
            }
        }
        get {
            return false
        }
    }

//var isEFR: Bool {
//   set {
//       self.spr_endRefreshing()
//   }
//   get {
//       return false
//   }
//}
    
    
    private func requestNetwork() {
        if delegateObj != nil {
            delegateObj?.endRreshData?(refreshStatu: true,
                                               Data: ["1","2","3"])
       }
    }
}


