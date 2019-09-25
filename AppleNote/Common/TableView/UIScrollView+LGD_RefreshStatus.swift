//
//  UIScrollView+LGD_RefreshStatus.swift
//  AppleNote
//
//  Created by kadis on 2019/9/25.
//  Copyright © 2019 mingcol. All rights reserved.
//

import Foundation
import UIKit

let LGD_RS_SW = UIScreen.main.bounds.size.width
let LGD_RS_SH = UIScreen.main.bounds.size.height

class UIScrollView {
    private var headerView:LGDRefreshHeaderView?
    private var footerView:LGDRefreshFooterView?
}

extension UIScrollView {
    enum LGD_RefreshStatus : Int {
        // 刷新状态
        case willRefresh = 0
        case refreshing = 1
        case cancelRefresh = 2
        case willLoad = 3
        case loading = 4
        case cancelLoad
    }
    
    
    // 刷新的回调
    typealias headerRefresh = (LGDRefreshHeaderView) -> Void
    typealias footerRefresh = (LGDRefreshFooterView) -> Void

    
    
    
    // 下拉刷新
    func LGD_addHeaderRefreshWithBlock(block:headerRefresh) {
        print("🍎")
        if (headerView == nil) {
            headerView = LGDRefreshHeaderView.init(frame: CGRect(x: 0, y: -50, width: LGD_RS_SW, height: 50))
        }
        
        
    }
    // 停止下拉刷新
    func endHeaderRefresh() {
        
    }
    
    // 上拉加载
    func LGD_addFooterRefreshWithBlock(block:footerRefresh) {
        print("🍉")
    }
    // 停止上拉加载
    func endFooterRefresh() {
        
    }
    
//    class headerBlock: headerBlock {
//
//    }
    
//    var headerBlock: headerRefresh?
//    var footerBlock: footerRefresh?
//    var refreshStatu: String?
//
//    // 下拉刷新
//    func jw_addHeaderRefresh(withBlock block: headerRefresh) {
//    }
//
//    func endHeaderRefresh() {
//    }
//
//    // 上拉加载
//    func jw_addFooterRefresh(withBlock block: footerRefresh) {
//    }
//
//    func endFooterRefresh() {
//    }
}
