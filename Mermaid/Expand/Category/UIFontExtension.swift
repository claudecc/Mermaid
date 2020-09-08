//
//  UIFontExtension.swift
//  SwiftLearning
//
//  Created by caixiaodong on 2020/3/31.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func pingfangLight(_ size:CGFloat) -> UIFont {
        var font = UIFont.init(name: "PingfangSC-Light", size: size)
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        return font!
    }
    
    class func pingfangThin(_ size:CGFloat) -> UIFont {
        var font = UIFont.init(name: "PingfangSC-Thin", size: size)
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        return font!
    }
    
    class func pingfangRegular(_ size:CGFloat) -> UIFont {
        var font = UIFont.init(name: "PingfangSC-Regular", size: size)
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        return font!
    }
    
    class func pingfangSemibold(_ size:CGFloat) -> UIFont {
        var font = UIFont.init(name: "PingfangSC-Semibold", size: size)
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        return font!
    }
    
    class func pingfangMedium(_ size:CGFloat) -> UIFont {
        var font = UIFont.init(name: "PingfangSC-Medium", size: size)
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        return font!
    }
    
    class func helvetica(_ size:CGFloat) -> UIFont {
        var font = UIFont.init(name: "Helvetica", size: size)
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        return font!
    }
    
}
