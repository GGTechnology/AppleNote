//
//  LGDRefreshFooterView.swift
//  AppleNote
//
//  Created by kadis on 2019/9/23.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit

var type: LGD_LoadShowType?
enum LGD_LoadShowType : Int {
    // 刷新状态
    case willLoad = 0
    case loading = 1
    case cancelLoad = 2
}

let loading = "正在加载更多"
let willLoad = "松手加载更多"
let cancelLoad = "上拉加载更多"
let SW = UIScreen.main.bounds.size.width
let SH = UIScreen.main.bounds.size.height
// 标题
var title: UILabel?
// 图片
var img: UIImageView?
// 加载「菊花」
var refreshView: UIActivityIndicatorView?

class LGDRefreshFooterView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
