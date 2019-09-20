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
//
//
//
//}

struct APModel {
    var num : String
    var date : String
    var address : String
    var content : String
    var image : Array<Any>
    
    init(jsonDate: JSON) {
        num = jsonDate["num"].stringValue
        date = jsonDate["date"].stringValue
        address = jsonDate["address"].stringValue
        content = jsonDate["content"].stringValue
        image = jsonDate["image"].arrayValue
    }
}
