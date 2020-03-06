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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 120;
        tableView.backgroundColor = colorWithHex(hexColor: 0xEFF4F6)
        tableView.delegateObj = self;
        tableView.isHFR = true;
        tableView.inteface = .note
        tableView.hRequestNetwork()
        
        return tableView
    }()
        
    override func viewDidLoad() {
        self.view.addSubview(tableView)
        
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
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0;
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


extension APNoteVC:APTableViewDelegate {
    internal func endRreshData(refreshStatu: Bool, _dataArray: Array<Any>, refreshDirection: Bool) {
        if refreshDirection {
            if (dataArray != nil) {
                dataArray = dataArray + _dataArray
            } else {
                dataArray = _dataArray
            }
        } else {
            dataArray = _dataArray;
        }
        self.tableView.reloadData()
    }
}
