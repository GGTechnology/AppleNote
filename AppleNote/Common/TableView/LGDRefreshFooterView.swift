//
//  LGDRefreshFooterView.swift
//  AppleNote
//
//  Created by kadis on 2019/9/23.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit

private var footerType: LGD_LoadShowType?
enum LGD_LoadShowType : Int {
    // 刷新状态
    case willLoad = 0
    case loading = 1
    case cancelLoad = 2
}

private let loading = "正在加载更多"
private let willLoad = "松手加载更多"
private let cancelLoad = "上拉加载更多"
private let footerSW = UIScreen.main.bounds.size.width
private let footerSH = UIScreen.main.bounds.size.height
// 标题
private var footerTitle: UILabel?
// 图片
private var footerImg: UIImageView?
// 加载「菊花」
private var footerRefreshView: UIActivityIndicatorView?

class LGDRefreshFooterView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.cyan
        creatViews()
        self.addObserver(self, forKeyPath: "footerType", options: .new, context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatViews() {
        if (footerTitle == nil) {
            footerTitle = UILabel.init(frame: CGRect(x: footerSW/3, y: 0, width: footerSW/3, height: 50))
            self.addSubview(footerTitle!)
            
        }
        if (footerImg == nil) {
            footerImg = UIImageView.init(frame: CGRect(x: footerSW/3-30, y: 10, width: 30, height: 30))
            footerImg?.image = UIImage.init(named: "jw_refresh")
            self.addSubview(footerImg!)
        }
        if (footerRefreshView == nil) {
            footerRefreshView = UIActivityIndicatorView.init(style: .gray)
            footerRefreshView?.center = CGPoint(x: footerSW/3-15, y: 25)
            footerRefreshView?.isHidden = true
            footerRefreshView?.startAnimating()
            self.addSubview(footerRefreshView!)
        }
        footerTitle?.font = UIFont.systemFont(ofSize: 18)
        footerTitle?.text = cancelLoad
        footerTitle?.textAlignment = .center
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "footerType") {
            footerTitle?.text = getRefreshStatus(status: footerType!)
            if (footerType! == .willLoad) {
                footerImg?.isHidden = false
                footerRefreshView?.isHidden = true
                UIView.animate(withDuration: 0.3, animations: {
                    footerImg?.transform = CGAffineTransform(rotationAngle: .pi)
                })
                UIView.animate(withDuration: 0.3) {
                    footerImg?.transform = CGAffineTransform(rotationAngle: .pi)
                }
            } else if (footerType! == .loading) {
                footerImg?.isHidden = true
                footerRefreshView?.isHidden = false
            } else {
                footerImg?.isHidden = false
                footerRefreshView?.isHidden = true
                UIView.animate(withDuration: 0.3) {
                    footerImg?.transform = CGAffineTransform(rotationAngle: 0)
                }
            }
        }
    }
    
    func getRefreshStatus(status:LGD_LoadShowType) -> String {
        switch status {
        case .willLoad:
            return willLoad
        case .loading:
            return loading
        case .cancelLoad:
            return cancelLoad
        default:
            break
        }
    }
}
