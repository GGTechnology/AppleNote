//
//  UIScrollView+Extensions
//  AppleNote
//
//  Created by kadis on 2019/9/25.
//  Copyright © 2019 mingcol. All rights reserved.
//

import Foundation
import UIKit

private var headerKey: UInt8 = 0
private var footerKey: UInt8 = 0
private var tempFooterKey: UInt8 = 0

extension UIScrollView {
    
    private var spr_header: LGDRefreshHeaderView {
        get {
            return objc_getAssociatedObject(self, &headerKey) as! LGDRefreshHeaderView
        }
        set {
            spr_header.removeFromSuperview()
            objc_setAssociatedObject(self, &headerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            newValue.map { insertSubview($0, at: 0) }
        }
    }
    
    
        
        


    

}

//enum LGD_RefreshStatus : Int {
//    // 刷新状态
//    case willRefresh = 0
//    case refreshing = 1
//    case cancelRefresh = 2
//    case willLoad = 3
//    case loading = 4
//    case cancelLoad
//}

//typealias headerRefresh = (LGDRefreshHeaderView) -> Void
//func LGD_addHeaderRefreshWithBlock(block:headerRefresh) {
//}
