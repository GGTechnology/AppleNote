//
//  APNoteViewController.swift
//  AppleNote
//
//  Created by kadis on 2019/8/20.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var tableview:LGDTableView!
var dataArray:Array<Any>!

class APNoteVC: APBaseVC {
    
    lazy var tableView:LGDTableView = {
        let tableView = LGDTableView(frame:self.view.bounds, style: UITableView.Style.grouped)
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 120;
        tableView.backgroundColor = colorWithHex(hexColor: 0xEFF4F6)
        let a:LGDRefreshFooterView!
//        tableView.LGD_addFooterRefreshWithBlock(block: { a in
//            print("下拉刷新")
//        })
//        tableView.LGD_addHeaderRefreshWithBlock(block: { (LGDRefreshHeaderView) in
//            print("上拉刷新")
//        })
        
        return tableView
    }()
    
    override func viewDidLoad() {
        self.view.addSubview(tableView)
        
        let urlStr:String = "https://raw.githubusercontent.com/GGTechnology/AppleNote/master/Configuration/AppleNote.json"
        AF.request(urlStr, method: .get).responseJSON {
            responds in
            switch responds.result {
            case .success(let value):
                dataArray = JSON(value).arrayValue
//                print("🍏", dataArray as Any, "🍎")
                self.tableView.reloadData()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

extension APNoteVC:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (dataArray != nil) {
            return dataArray.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = APNoteCell()
        cell.setDate(model: setModelValue(row: indexPath.row))
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("🍎", indexPath.row)
    }
    
    func setModelValue(row:Int) -> (APModel) {
        if (dataArray != nil) {
            let data:JSON = JSON(dataArray[row])
            let model = APModel(jsonData: data)
            return model
        } else {
            let model = APModel(jsonData: JSON())
            return model
        }
    }
}
