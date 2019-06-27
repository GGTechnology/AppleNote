//
//  ViewController.swift
//  Alamofire网络请求
//
//  Created by mingcol on 2019/6/26.
//  Copyright © 2019 mingcol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let urlStr:String = "http://f.apiplus.cn/ssq.json"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🍎")
        print("🍎")
        
//        one()
//        two()
//        three()
//        four()
//        five()
//        six()
//        seven()
//        eight()
    }
    //  1. response()
    func one() {
        //  1. response()
        // 官方解释：The response handler does NOT evaluate any of the response data. It merely forwards on all information directly from the URL session delegate. It is the Alamofire equivalent of using cURL to execute a Request.
        AF.request(urlStr).response {
            (returnResult) in
            if let data = returnResult.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("firstMethod --> response() --> utf8Text = \(utf8Text)")
            }
        }
    }
    //  2. responseData()
    func two() {
        //  2. responseData()
        //  官方解释：The responseData handler uses the responseDataSerializer (the object that serializes the server data into some other type) to extract the Data returned by the server. If no errors occur and Data is returned, the response Result will be a .success and the value will be of type Data.
        AF.request(urlStr).responseData {
            (returnResult) in
            debugPrint("firstMethod --> responseData() --> returnResult = \(returnResult)")
            if let data = returnResult.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("firstMethod --> responseData() --> utf8Text = \(utf8Text)")
            }
        }
    }
    // 3. responseString()
    func three() {
        // 3. responseString()
        // 官方解释：The responseString handler uses the responseStringSerializer to convert the Data returned by the server into a String with the specified encoding. If no errors occur and the server data is successfully serialized into a String, the response Result will be a .success and the value will be of type String.
        AF.request(urlStr).responseString {
            (returnResult) in
            debugPrint("firstMethod --> responseString() --> value = \(String(describing: returnResult.result.value))")
            print("firstMethod --> responseString() --> returnResult = \(returnResult)")
        }
    }
    // 4. responseJSON()
    func four() {
        // 4. responseJSON()
        // 官方解释：The responseJSON handler uses the responseJSONSerializer to convert the Data returned by the server into an Any type using the specified JSONSerialization.ReadingOptions. If no errors occur and the server data is successfully serialized into a JSON object, the response Result will be a .success and the value will be of type Any.
        AF.request(urlStr).responseJSON {
            (returnResult) in
            debugPrint("firstMethod --> responseJSON --> \(returnResult)")
            if let json = returnResult.result.value {
                print("firstMethod --> responseJSON --> \(json)")
                /// 返回请求地址、数据、和状态结果等信息
                 print("1、firstMethod --> responseJSON() --> \(returnResult.request!)")
                 print("2、firstMethod --> responseJSON() --> \(returnResult.data!)")
                 print("3、firstMethod --> responseJSON() --> \(returnResult.result)")
            }
        }
    }
    // 1. GET请求
    func five() {
        // 1. GET请求
        AF.request(urlStr, method: .get).responseJSON {
            (returnResult) in
            print("secondMethod --> GET 请求 --> returnResult = \(returnResult)")
        }
    }
    // 2. POST请求
    func six() {
        AF.request(urlStr, method: .post).responseJSON { (returnResult) in
            print("secondMethod --> POST 请求 --> returnResult = \(returnResult)")
        }
    }
    // 3. 参数、编码
    func seven() {
        // 官方解释：Alamofire supports three types of parameter encoding including: URL, JSON and PropertyList. It can also support any custom encoding that conforms to the ParameterEncoding protocol.
        let param = [
            "key1" : "value1",
            "key2" : "value2"
        ]
        AF.request(urlStr, method: .post, parameters: param).responseJSON { (returnResult) in
            print("secondMethod --> 参数 --> returnResult = \(returnResult)")
        }
        // AF.request(urlStr, method: .post, parameters: param, encoding: URLEncoding.default)
        // AF.request(urlStr, method: .post, parameters: param, encoding: URLEncoding(destination: .methodDependent))
    }
    // 4.请求头
    func eight() {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        AF.request(urlStr, headers: headers).responseJSON {
            (returnResult) in
            print("secondMethod --> 请求头 --> returnResult = \(returnResult)")
        }
    }
}

