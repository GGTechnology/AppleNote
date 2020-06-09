//
//  DEFINE.swift
//  Swift 常用扩展类和简单封装
//
//  Created by kadis on 2020/6/6.
//  Copyright © 2020 lvguangda. All rights reserved.
//

import Foundation
import UIKit

/**
 * UIColor的扩展类 将16进制颜色转换为RGB
 * @param hexString 16进制颜色字符串
 */
extension UIColor{
    convenience init(hexString: String) {
        let scanner:Scanner = Scanner(string:hexString)
        var valueRGB:UInt64 = 0
        if scanner.scanHexInt64(&valueRGB) == false {
            self.init(red: 0,green: 0,blue: 0,alpha: 0)
        }else{
            self.init(
                red:CGFloat((valueRGB & 0xFF0000)>>16)/255.0,
                green:CGFloat((valueRGB & 0x00FF00)>>8)/255.0,
                blue:CGFloat(valueRGB & 0x0000FF)/255.0,
                alpha:CGFloat(1.0)
            )
        }
    }
}

/**
 * 扩展UIColor 生成随机颜色
 */
extension UIColor {
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}

/**
 * UITapGestureRecognizer 的扩展类 给手势添加一个tag属性
 */
private var tagKey: Int?
extension UITapGestureRecognizer {
    var gestureTag: Int? {
        get {
            return objc_getAssociatedObject(self, &tagKey) as? Int
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tagKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
}

/**
 * String 的扩展类
 * MD5 加密
 */
extension String {
    func getMD5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)
        return String(hash)
    }
}

/**
 * UIViewController 的扩展类 获取当前的ViewController
 * 使用时只需let nowVC = UIViewController.currentViewController()
 */
extension UIViewController {
    
//    1、这种获取的 keyWindow 可以做很多的和以前一样的操作，例如：keyWindow?.endEditing(true)
//
//    let keyWindow = UIApplication.shared.connectedScenes
//    .filter({$0.activationState == .foregroundActive})
//    .map({$0 as? UIWindowScene})
//    .compactMap({$0})
//    .first?.windows
//    .filter({$0.isKeyWindow}).first
    
//    2、还使用 UIApplication.shared.keyWindow 的方式获取 keyWindow 会警告
//
//    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    
    // 上面 2 中因为 keyWindow 在 iOS13 已经抛弃了，所以 keyWindow 用 1 的方式获取
    
    class func currentViewController(base: UIViewController? = UIApplication.shared.connectedScenes
    .filter({$0.activationState == .foregroundActive})
    .map({$0 as? UIWindowScene})
    .compactMap({$0})
    .first?.windows
    .filter({$0.isKeyWindow}).first?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}
