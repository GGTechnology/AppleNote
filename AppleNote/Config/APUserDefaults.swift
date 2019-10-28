//
//  APUserDefaults.swift
//  AppleNote
//
//  Created by kadis on 2019/10/28.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit

class APUserDefaults: NSObject {

}

/**
* 存储对象 KEY : VALUE
*/
func setDefault(key:String,value:AnyObject?){
    if value == nil {
        UserDefaults.standard.removeObject(forKey: key)
    } else {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize() //同步
    }
}

/**
* 移除对象 KEY : VALUE
*/
func removeUserDefault(key:String?){
    if key != nil {
        UserDefaults.standard.removeObject(forKey: key!)
        UserDefaults.standard.synchronize()
    }
}

/**
* 获取对象 KEY : VALUE
*/
func getDefault(key:String) ->AnyObject?{
    return UserDefaults.standard.value(forKey: key) as AnyObject?
}
