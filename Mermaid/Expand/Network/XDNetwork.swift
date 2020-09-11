//
//  XDNetwork.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2019/7/17.
//  Copyright © 2019 蔡晓东. All rights reserved.
//

import UIKit
import Alamofire

#if DEBUG         // 调试版本
let appURL = "www.baidu.com"
#else             // 发布版本
let appURL = "offical"
#endif

class XDNetwork: NSObject {
    /**
     *  网络请求成功闭包:(回调成功结果)
     */
    typealias NetworkSuccess = (_ response:AnyObject) -> ()
    
    /**
     *  网络请求失败闭包:(回调失败结果)
     */
    typealias NetworkFailure = (_ error:Error?, _ des:String?) -> ()
    
    /**
     *  网络请求单例
     */
    static let shareNetwork = XDNetwork()
    
    /**
     GET 请求
     - parameter urlString:  请求URL
     - parameter parameters: 请求参数
     - parameter success:    成功回调
     - parameter failure:    失败回调
     */
    func GET(urlString: String ,parameters: [String : String]? ,success: @escaping NetworkSuccess, failure: @escaping NetworkFailure){
        /*
         responseJSON:申明返回JSON类型数据
         你也可以根据实际需求,修改返回下列类型
         response
         responseData
         responseString
         responsePropertyList
         */
        var mutableParas = ["refer":"ios","pf_ver":"10.1.0","ver":"3.5","fr":"applestore","an":"200"]
        if let paras = parameters {
            for (key,value) in paras {
                mutableParas.updateValue(key, forKey: value)
            }
        }
        
//        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
////            print(response.request)  // 原始的URL请求
////            print(response.response) // HTTP URL响应
////            print(response.data)     // 服务器返回的数据
////            print(response.result)   // 响应序列化结果，在这个闭包里，存储的是JSON数据
//
//            switch response.result.isSuccess {
//            case true:
//                if let result = response.result.value {
//                    success(result as AnyObject)
//                } else {
////                    print("没有数据")
//                    failure(nil,"没有数据")
//                }
//            case false:
//                if let error = response.result.error {
//                    debugPrint(error)
//                    failure(error,nil)
//                } else {
////                    print("网络请求出错")
//                    failure(nil,"网络请求出错")
//                }
//            }
//        }
    }
    
    /**
     POST 请求
     - parameter urlString:  请求URL
     - parameter parameters: 请求参数
     - parameter success:    成功回调
     - parameter failure:    失败回调
     */
    func POST(urlString: String ,parameters: [String : String]? ,success: @escaping NetworkSuccess, failure: @escaping NetworkFailure) {

//        Alamofire.request(.POST, urlString, parameters: parameters).responseJSON { response in
//
//            switch response.result {
//
//            case .Success(let value):
//
//                //回调成功结果
//                success(value)
//
//            case .Failure(let error):
//
//                //回调失败结果
//                failure(error)
//                debugPrint(error)
//
//            }
//        }
        
//        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
//
//            switch response.result.isSuccess {
//            case true:
//                if let result = response.result.value {
//                    success(result as AnyObject)
//                } else {
//                    print("没有数据")
//                    failure(nil,"没有数据")
//                }
//            case false:
//                if let error = response.result.error {
//                    debugPrint(error)
//                    failure(error,nil)
//                } else {
//                    print("网络请求出错")
//                    failure(nil,"网络请求出错")
//                }
//            }
//        }

    }
    
}

/**
 调用
 XDNetwork.shareNetwork.GET(urlString: XDInterface.bannerUrl, parameters: nil, success: { (result) in
 print(result)
 if let dict = result as? Dictionary<String, AnyObject> {
 if let message = dict["message"] {
 print(message)
 }
 }
 }) { (error, text) in
 
 }
 */
