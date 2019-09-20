//
//  DEFINE.swift
//  iStorage
//
//  Created by Mingcol on 2019/2/26.
//  Copyright © 2019年 Mac Mini_A. All rights reserved.
//

import Foundation
import UIKit

//屏幕大小
let ScreenSize                           = UIScreen.main.bounds.size
//屏幕宽度
let ScreenWidth:CGFloat                  = UIScreen.main.bounds.size.width
//屏幕高度
let ScreenHeight:CGFloat                 = UIScreen.main.bounds.size.height

//根据传入的值算出乘以比例之后的值
func width(width:CGFloat) ->CGFloat {
    return UIScreen.main.bounds.size.width * CGFloat(ceil(Float(width))) / 414
}

func height(height:CGFloat) ->CGFloat {
    return UIScreen.main.bounds.size.height * CGFloat(ceil(Float(height))) / 736
}

// 十六进制颜色：colorWithHex(hexColor: 0xF57242)
func colorWithHex(hexColor:Int64)->UIColor{
    let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0;
    let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0;
    let blue = ((CGFloat)(hexColor & 0xFF))/255.0;
    return UIColor(red: red, green: green, blue: blue, alpha: 1)
}
// rgb颜色转换（16进制->10进制）
func colorWithRGB(R:CGFloat,G:CGFloat,B:CGFloat,A:CGFloat) ->UIColor {
    return UIColor.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
}

// MARK: - 设备信息

/// 当前app信息
let GetAppInfo = Bundle.main.infoDictionary
/// 当前app版本号
let GetAppCurrentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
/// 获取设备系统号
let GetSystemVersion = UIDevice.current.systemVersion

// 状态栏高度
let StatusBar = UIApplication.shared.statusBarFrame.size.height
// 导航栏高度
let NavHeight = 44

/// iPhone设备
let isIPhone = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false)
/// iPad设备
let isIPad = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false)

/// iPhone4设备
let isIPhone4 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) < 568.0 ? true : false)
/// iPhone5设备
let isIPhone5 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) == 568.0 ? true : false)
/// iPhone6设备
let isIPhone6 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) == 667.0 ? true : false)

/// iPhone6Plus设备
let isIPhone6P = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) == 736.0 ? true : false)



