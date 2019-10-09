//
//  LGDRefreshHeaderView.swift
//  AppleNote
//
//  Created by kadis on 2019/9/23.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit

private var headerType: LGD_LoadRefreshShowType?
enum LGD_LoadRefreshShowType : Int {
    // 刷新状态
    case willLoad = 0
    case loading = 1
    case cancelLoad = 2
}

private let refreshing = "正在刷新数据"
private let willRefresh = "松手刷新数据"
private let cancelRefresh = "下拉刷新数据"
private let headerSW = UIScreen.main.bounds.size.width
private let headerSH = UIScreen.main.bounds.size.height
// 标题
private var headerTitle: UILabel?
// 图片
private var headerImg: UIImageView?
// 加载「菊花」
private var headerRefreshView: UIActivityIndicatorView?

class LGDRefreshHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: -50, width: headerSW, height: 50)
        creatViews()
        self.addObserver(self, forKeyPath: "headerType", options: .new, context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatViews() {
        if (headerTitle == nil) {
            headerTitle = UILabel(frame: CGRect(x: headerSW / 3, y: 0, width: headerSW / 3, height: 50))
            addSubview(headerTitle!)
        }
        if (headerImg == nil) {
            headerImg = UIImageView(frame: CGRect(x: headerSW / 3 - 30, y: 10, width: 30, height: 30))
            headerImg?.image = UIImage(named: "jw_refresh")
            headerImg?.transform = CGAffineTransform(rotationAngle: .pi)
            addSubview(headerImg!)
        }
        if (headerRefreshView == nil) {
            headerRefreshView = UIActivityIndicatorView(style: .gray)
            headerRefreshView?.center = CGPoint(x: headerSW / 3 - 15, y: 25)
            headerRefreshView?.isHidden = true
            headerRefreshView?.startAnimating()
            addSubview(headerRefreshView!)
        }
        headerTitle?.font = UIFont.systemFont(ofSize: 18)
        headerTitle?.text = cancelRefresh
        headerTitle?.textAlignment = .center

        self.backgroundColor = .orange
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // 处理刷新视图的改变
        if (keyPath == "headerType") {
            headerTitle?.text = getRefreshStatus(status: headerType!)
            if (headerType! == .willLoad) {
                headerImg?.isHidden = false
                headerRefreshView?.isHidden = true
                UIView.animate(withDuration: 0.3, animations: {
                    headerImg?.transform = CGAffineTransform(rotationAngle: 0)
                })
            } else if (headerType! == .loading) {
                headerImg?.isHidden = true
                headerRefreshView?.isHidden = false
            } else {
                headerImg?.isHidden = false
                headerRefreshView?.isHidden = true
                UIView.animate(withDuration: 0.3, animations: {
                    headerImg?.transform = CGAffineTransform(rotationAngle: .pi)
                })
            }
        }
    }
    
    func getRefreshStatus(status:LGD_LoadRefreshShowType) -> String {
        switch status {
        case .willLoad:
            return willRefresh
        case .loading:
            return refreshing
        case .cancelLoad:
            return cancelRefresh
        default:
            break
        }
    }
}
