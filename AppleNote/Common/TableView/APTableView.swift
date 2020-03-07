//
//  APTableView.swift
//  AppleNote
//
//  Created by kadis on 2019/10/29.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@objc protocol APTableViewDelegate:NSObjectProtocol {
    @objc optional func endRreshData (refreshStatu:Bool, _dataArray:Array<Any>, refreshDirection:Bool)
}

class APTableView: UITableView {
    
    weak var delegateObj: APTableViewDelegate?
    
    enum RefreshDirection {
        case header, footer
    }
    
    var inteface:APRequestURLInteface!
    var parameter:Dictionary<String, Any>!
    private var page:Int = 0
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.sectionFooterHeight = 0
        self.sectionHeaderHeight = 0
//        self.dataSource = self
//        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // 是否有头部刷新
    var _isHR: Bool?
    var isHR: Bool? {
        set {
            _isHR = newValue
            if _isHR! {
                self.spr_setIndicatorHeader {
                    self.RequestNetwork(refreshDirection: .header)
                }
            }
        }
        get {
            return _isHR
        }
    }
    // 是否有脚部刷新
    var _isFR: Bool?
    var isFR: Bool? {
        set {
            _isFR = newValue
            if _isFR! {
                self.spr_setIndicatorFooter {
                    self.RequestNetwork(refreshDirection: .footer)
                }
            }
        }
        get {
            return _isFR
        }
    }
    // 是否有头部&脚部刷新
    var _isHFR: Bool?
    var isHFR: Bool? {
        set {
            _isHFR = newValue
            if _isHFR! {
                self.spr_setIndicatorFooter {
                    self.RequestNetwork(refreshDirection: .footer)
                }
                self.spr_setIndicatorHeader {
                    self.RequestNetwork(refreshDirection: .header)
                }
            }
        }
        get {
            return _isHFR
        }
    }
    
    func RequestNetwork(refreshDirection:RefreshDirection) {
        switch refreshDirection {
        case .header:
            page = 0
            let urlStr:String = AP_GetRequestStr(inteface: inteface) + String(0) + ".json"
            AF.request(urlStr, method: .get).responseJSON {
                responds in
                switch responds.result {

                case .success(let value):
                    let array = JSON(value).arrayValue
                    if (array.count > 0) {
                        self.page += 1
                        self.spr_endRefreshing()
                    }
                    if self.delegateObj != nil {
                        self.delegateObj?.endRreshData?(refreshStatu: true,
                                                    _dataArray: array, refreshDirection: false)
                    }
                    self.delayEndRefresh()
                    break
                case .failure(let error):
                    self.spr_endRefreshing()
                    print(error)
                    break
                }
            }
            break
        default:
            let urlStr:String = AP_GetRequestStr(inteface: inteface!) + String(page) + ".json"
            AF.request(urlStr, method: .get).responseJSON {
                responds in
                switch responds.result {

                case .success(let value):
                    let array = JSON(value).arrayValue
                    
                    if (array.count > 0) {
                        self.page += 1
                        self.spr_endRefreshing()
                    }
                    if self.delegateObj != nil {
                        self.delegateObj?.endRreshData?(refreshStatu: true,
                                                        _dataArray: array, refreshDirection: true)
                    }
                    self.delayEndRefresh()
                    break
                case .failure(let error):
                    self.spr_endRefreshing()
                    print(error)
                    break
                }
            }
            break
        }
    }
    
    private func delayEndRefresh() {
        //    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        //        self.spr_endRefreshing()
        //    }
    }
}

//extension APTableView: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell:UITableViewCell = UITableViewCell alloc
//        return UITableViewCell()
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        // 有下一页数据
//        if false {
//            return 0
//        } else {
//            return 50
//        }
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        // 有下一页数据
//        if false {
//            return UIView()
//        } else {
//            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: 50))
//            view.backgroundColor = .clear
//            view.backgroundColor = .cyan
//
//            return view
//
//        }
//    }
//}
