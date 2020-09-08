//
//  TestJsonModelTool.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2019/7/28.
//  Copyright © 2019 蔡晓东. All rights reserved.
//

import UIKit
import ObjectMapper

//@objcMembers // 所有的类成员都暴露于Objective-C（在属性类里面使用）

class TestJsonModelTool: NSObject {
    
    func originalJsonToModel(data:Any) {
        if let path = Bundle.main.path(forResource: "TestJsonData", ofType: "plist") {
            let data:NSData?
            do {
                data = try NSData(contentsOfFile: path)
                
            } catch let error {
                debugPrint(error)
            }
        }
        
    }
    
    func swiftyJsonToModel(data:Any) {
        
    }
    /**
     Deserialization
     class BasicTypes: HandyJSON {
     var int: Int = 2
     var doubleOptional: Double?
     var stringImplicitlyUnwrapped: String!
     
     required init() {}
     }
     
     let jsonString = "{\"doubleOptional\":1.1,\"stringImplicitlyUnwrapped\":\"hello\",\"int\":1}"
     if let object = BasicTypes.deserialize(from: jsonString) {
     print(object.int)
     print(object.doubleOptional!)
     print(object.stringImplicitlyUnwrapped)
     }
     Serialization
     let object = BasicTypes()
     object.int = 1
     object.doubleOptional = 1.1
     object.stringImplicitlyUnwrapped = “hello"
     
     print(object.toJSON()!) // serialize to dictionary
     print(object.toJSONString()!) // serialize to JSON string
     print(object.toJSONString(prettyPrint: true)!) // serialize to pretty JSON string
     */
    
    class func testJsonToModel() {
        let json = ["data":["name":"ccc"]]
        if let data = Mapper<TestMainModel<TestMainDataModel>>().map(JSON: json)?.data {
            print("ddd")
        }
    }
    
}


class TestMainModel<T: Mappable>: NSObject, Mappable {
    
    var data: T?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class TestMainDataModel: NSObject, Mappable {
    var name: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["name"]
    }
}
