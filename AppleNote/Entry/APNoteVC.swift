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

private var tableview:APTableView!
private var dataArray:Array<Any>!
private var page:Int = 0

class APNoteVC: APBaseVC {
    
    lazy var tableView:APTableView = {
        let tableView = APTableView(frame:self.view.bounds, style: UITableView.Style.grouped)
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 120;
        tableView.backgroundColor = colorWithHex(hexColor: 0xEFF4F6)
        
        tableView.spr_setIndicatorHeader {
//            [weak self] in self?.action()
            [weak self] in self?.request(page: page)
        }
        
        return tableView
    }()
    
    func action() {
        page += 1
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView.spr_endRefreshing()
//        }
    }
    
    override func viewDidLoad() {
        self.view.addSubview(tableView)
        request(page: page)
    }
    
    func request(page:Int) {
        let urlStr:String = APNoteJson + "apple" + String(page) + ".json"
            
        AF.request(urlStr, method: .get).responseJSON {
            responds in
            switch responds.result {
                
            case .success(let value):
                if (dataArray != nil) {
                    dataArray = dataArray + JSON(value).arrayValue
                } else {
                    dataArray = JSON(value).arrayValue
                }
//                print("🍏", dataArray ?? "🍍")
                if (dataArray.count > 0) {
                    self.action()
                }
                self.tableView.reloadData()
                break
            case .failure(let error):
                print("🌐")
                print(error)
                print("🌐")
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
