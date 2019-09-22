//
//  APModel.swift
//  AppleNote
//
//  Created by kadis on 2019/8/21.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit
import SwiftyJSON

//class APModel: NSObject {
//}

struct APModel {
    var num : String
    var day : String
    var week : String
    var time : String
    var date : String
    var address : String
    var content : String
    var image : Array<Any>
    
    init(jsonData: JSON) {
        num = jsonData["num"].stringValue
        day = jsonData["day"].stringValue
        week = jsonData["week"].stringValue
        time = jsonData["time"].stringValue
        date = jsonData["date"].stringValue
        address = jsonData["address"].stringValue
        content = jsonData["content"].stringValue
        image = jsonData["image"].arrayValue
    }
}

struct bModel {
    var a:String
    init() {
        a = "a"
    }
}
