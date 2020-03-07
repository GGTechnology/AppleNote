//
//  APShoppingViewController.swift
//  AppleNote
//
//  Created by kadis on 2019/8/20.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit

private var tableview:APTableView!
private var tCount:Int!

class APShoppingVC: APBaseVC {
    
    lazy var tableView:APTableView = {
        let tableView = APTableView(frame:self.view.bounds, style: UITableView.Style.plain)
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 120;
        tableView.backgroundColor = colorWithHex(hexColor: 0xEFF4F6)
        tableView.isFR = true
        tableView.isHR = true
        tableView.delegateObj = self

        return tableView
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        // exit(0)
        
        tCount = 20;
        
        self.view.addSubview(tableView)
        
        userTest()  // 存储Data、删除Data、获取Data
        
        tableView.inteface = .note
        tableView.parameter = ["key" : "value"]
        
        exit(0)
    }
    
    func userTest() {
        let btn1 = UIButton.init(frame: CGRect(x: 100, y: 100, width: 150, height: 50))
        btn1.backgroundColor = .randomColor
        btn1.titleLabel?.text = "存储"
        btn1.setTitle("存储", for: .normal)
        btn1.addTarget(self, action: #selector(save), for: .touchUpInside)
        self.view.addSubview(btn1)
        
        let btn2 = UIButton.init(frame: CGRect(x: 100, y: 200, width: 150, height: 50))
        btn2.backgroundColor = .randomColor
        btn2.titleLabel?.text = "获取"
        btn2.setTitle("获取", for: .normal)
        btn2.addTarget(self, action: #selector(prints), for: .touchUpInside)
        self.view.addSubview(btn2)
        
        let btn3 = UIButton.init(frame: CGRect(x: 100, y: 300, width: 150, height: 50))
        btn3.backgroundColor = .randomColor
        btn3.setTitle("清除", for: .normal)
        btn3.titleLabel?.textColor = .white
        btn3.addTarget(self, action: #selector(clean), for: .touchUpInside)
        self.view.addSubview(btn3)
    }
    @objc func save() {
        print("存储")
        setDefault(key: "aa", value: "bb" as AnyObject)
    }
    @objc func prints() {
        print("获取")
        print(getDefault(key: "aa") ?? "无数据")
    }
    @objc func clean() {
        print("清除")
        removeUserDefault(key: "aa")
    }
}

extension APShoppingVC:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(indexPath.row)
        if indexPath.row%2 == 0 {
            cell.backgroundColor = .brown
        } else {
            cell.backgroundColor = .orange
        }
        return cell;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 20
        return tCount
    }
}

extension APShoppingVC:APTableViewDelegate {
    func endRreshData(refreshStatu: Bool, Data: Array<Any>) {
        print(refreshStatu)
        tCount += Data.count
        self.tableView.parameter = ["🍇":"🍌"]
        self.tableView.reloadData()
    }
}
