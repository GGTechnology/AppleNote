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
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.cyan
        creatViews()
        self.addObserver(self, forKeyPath: "type", options: .new, context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatViews() {
        if (title == nil) {
            title = UILabel.init(frame: CGRect(x: SW/3, y: 0, width: SW/3, height: 50))
            self.addSubview(title!)
            
        }
        if (img == nil) {
            img = UIImageView.init(frame: CGRect(x: SW/3-30, y: 10, width: 30, height: 30))
            img?.image = UIImage.init(named: "jw_refresh")
            self.addSubview(img!)
        }
        if (refreshView == nil) {
            refreshView = UIActivityIndicatorView.init(style: .gray)
            refreshView?.center = CGPoint(x: SW/3-15, y: 25)
            refreshView?.isHidden = true
            refreshView?.startAnimating()
            self.addSubview(refreshView!)
        }
        title?.font = UIFont.systemFont(ofSize: 18)
        title?.text = cancelLoad
        title?.textAlignment = .center
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "type") {
            title?.text = getRefreshStatus(status: type!)
            if (type! == .willLoad) {
                img?.isHidden = false
                refreshView?.isHidden = true
                UIView.animate(withDuration: 0.3, animations: {
                    img?.transform = CGAffineTransform(rotationAngle: .pi)
                })
                UIView.animate(withDuration: 0.3) {
                    img?.transform = CGAffineTransform(rotationAngle: .pi)
                }
            } else if (type! == .loading) {
                img?.isHidden = true
                refreshView?.isHidden = false
            } else {
                img?.isHidden = false
                refreshView?.isHidden = true
                UIView.animate(withDuration: 0.3) {
                    img?.transform = CGAffineTransform(rotationAngle: 0)
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
