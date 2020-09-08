//
//  TestNetWorkTool.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2019/7/28.
//  Copyright © 2019 蔡晓东. All rights reserved.
//

import UIKit

class TestNetWorkTool: NSObject {
    
}

protocol Summable: Numeric {
    static func +(lhs: Self, rhs: Self) -> Self
    static func -(lhs: Self, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Self) -> Self
    static func /(lhs: Self, rhs: Self) -> Self
    func toInt() -> Int
    func toCGFloat() -> CGFloat
    func toString() -> String
}
extension Int: Summable {
    func toInt() -> Int {
        return self
    }
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
    func toString() -> String {
        return "\(self)"
    }
}
extension Float: Summable {
    func toInt() -> Int {
        let value = Int(self)
        return value
    }
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
    func toString() -> String {
        return "\(self)"
    }
}
extension Double: Summable {
    func toInt() -> Int {
        let value = Int(self)
        return value
    }
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
    func toString() -> String {
        return "\(self)"
    }
}

class PriceRangeView<T: Summable>: UIView {
    
    var minValue: T = 0
    var maxValue: T = 0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(minValue: T, maxValue: T) {
        super.init(frame: .zero)
        
        self.minValue = minValue
        self.maxValue = maxValue
    }
    
    func calculate() {
        let value = (maxValue - minValue).toCGFloat()
        if Int.Type.self == T.Type.self {
            print(String(format: "%.0f", value))
        } else if Float.Type.self == T.Type.self {
            print(String(format: "%.1f", value))
        } else if Double.Type.self == T.Type.self {
            print(String(format: "%.1f", value))
        }
        
    }
    
}
