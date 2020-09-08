//
//  Interface.swift
//  SwiftLearning
//
//  Created by claudechoi on 2018/4/10.
//  Copyright © 2018年 蔡晓东. All rights reserved.
//

import UIKit

class Interface: NSObject {
    
    private static let instance = Interface()
    
    class func shareInstance() -> Interface {
        return instance;
    }
    
}
