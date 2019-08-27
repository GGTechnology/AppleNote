//
//  APNoteViewController.swift
//  AppleNote
//
//  Created by kadis on 2019/8/20.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit

var a = 10
var tableview:UITableView!

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
        return tableView
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .cyan
        self.view.addSubview(tableView)
    }
}

extension APNoteVC:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(indexPath.row)
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
}
