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

var a = 10
var tableview:UITableView!
var dataArray:Array<Any>!
//var dataArray = [String]()
var array = ["愿这个世界与你温柔相待🌃",
             "简单精致，记录生活😘😘😘",
             "有的路，你必须一个人走，这不是孤独，而是选择...🏃",
             "长大了，总有那么一两次，你会为重视的人奔跑，因为是对的人，走路真的来不及",
             "总有人说你变了，却没有问你经历过什么。😄",
             "孤独的日子，往往是你迅速成长的日子。☁️",
             "Hello World 🌞"]
var imageArray = ["123", "456", "123", "456"]

class APNoteVC: APBaseVC {
    
    lazy var names: NSArray = {
        let names = NSArray()
        print("只在首次访问输出")
        return names
    }()
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame:self.view.bounds, style: UITableView.Style.grouped)
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 110;
        return tableView
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .cyan
        self.view.addSubview(tableView)
        
        let urlStr:String = "https://raw.githubusercontent.com/GGTechnology/AppleNote/master/Configuration/AppleNote.json"
        AF.request(urlStr, method: .get).responseJSON {
            responds in
            switch responds.result {
            case .success(let value):
                dataArray = JSON(value).arrayValue
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
        return 2
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
