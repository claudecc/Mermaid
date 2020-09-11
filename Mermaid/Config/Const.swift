//
//  Const.swift
//  SwiftLearning
//
//  Created by caixiaodong on 2020/3/31.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

import UIKit

let StatusBarH:CGFloat = UIApplication.shared.statusBarFrame.height
let NavibarH:CGFloat = StatusBarH + 44.0
let IsIPhoneXSeries:Bool = (StatusBarH == 44.0) ? true : false
let BottomSafeH:CGFloat = IsIPhoneXSeries ? 34.0 : 0

let ScreenW:CGFloat = UIScreen.main.bounds.width
let ScreenH:CGFloat = UIScreen.main.bounds.height

let kWindow = UIApplication.shared.delegate?.window


func BLColorFromRGB(rgbValue: UInt32) -> UIColor {
    
    let temp = UInt32(255.0)
    
    let red = ((rgbValue & 0xFF0000) >> 16) / temp
    let green = ((rgbValue & 0xFF00) >> 8) / temp
    let blue = (rgbValue & 0xFF) / temp
    
    return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
}

func RGBCOLOR(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}
