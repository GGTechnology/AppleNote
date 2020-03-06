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
    
    var inteface:APRequestURLInteface!
    var parameter:Dictionary<String, Any>!
    private var page:Int = 0
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.sectionFooterHeight = 0
        self.sectionHeaderHeight = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // 是否有头部刷新
    var isHR: Bool? {
        set {
            if newValue! {
                self.spr_setIndicatorHeader {
                    self.hRequestNetwork()
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
                    self.fRequestNetwork()
                }
            }
        }
        get {
            return false
        }
    }
    // 是否有头部&脚部刷新
    var isHFR: Bool? {
        set {
            if newValue! {
                self.spr_setIndicatorFooter {
                    self.fRequestNetwork()
                }
                self.spr_setIndicatorHeader {
                    self.hRequestNetwork()
                }
            }
        }
        get {
            return false
        }
    }

    
    func hRequestNetwork() {
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
    }
    private func fRequestNetwork() {
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
    }
    
    private func delayEndRefresh() {
        //    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        //        self.spr_endRefreshing()
        //    }
    }
}


