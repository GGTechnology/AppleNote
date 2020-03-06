//
//  APNetworkInteface.swift
//  AppleNote
//
//  Created by kadis on 2020/3/6.
//  Copyright © 2020 mingcol. All rights reserved.
//

import Foundation

private let URL:String = "https://gitee.com/ggkeji/AppleNote/raw/master/Source/"

//let APNoteJson:String = "https://gitee.com/ggkeji/AppleNote/raw/master/Source/note/"
//let APNoteImage:String = "https://gitee.com/ggkeji/AppleNote/raw/master/Source/image/index/"

public enum APRequestURLInteface {
    case note
    case image
    case none
}

public func AP_GetRequestStr(inteface:APRequestURLInteface) -> (String) {
    
    switch inteface {
    case .note:
        return SplicingString(parameter: "note/apple")
    case .image:
        return SplicingImage(parameter: "image/index")
    default:
        return ""
    }
}

private func SplicingString(parameter:String) -> String {
    return URL + parameter
}

private func SplicingImage(parameter:String) -> String {
    return URL + parameter
}
