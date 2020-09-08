//
//  LoadingView.swift
//  SwiftLearning
//
//  Created by claudechoi on 2018/3/30.
//  Copyright © 2018年 蔡晓东. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    private static let instance = Interface()
    
    class func shareInstance() -> Interface {
        return instance;
    }

}
