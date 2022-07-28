//
//  UITextViewExtension.swift
//  SwiftLearning
//
//  Created by caixiaodong on 2020/4/1.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

import UIKit

extension UITextView {
    
    
    
    var xd_placeHolder:String {
        get {
            return ""
        }
        set {
            if newValue.isEmpty == false {
                return
            }
            // create a placeholder label
            let placeholderLabel = UILabel()
            placeholderLabel.text = newValue
            
            self.addSubview(placeholderLabel)
            placeholderLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(10)
                make.left.equalToSuperview().offset(10)
                make.right.lessThanOrEqualToSuperview().offset(-10)
            }
        }
    }
    
    var xd_placeHolderColor:UIColor {
        get {
            return UIColor.red
        }
        set {
            
        }
    }
    
    var xd_maxLength:Int {
        get {
            return 0
        }
        set {
            if newValue < 0 {
                return
            }
            // create a number label
            let numberLabel = UILabel()
            numberLabel.text = String(newValue)
            
            self.addSubview(numberLabel)
            numberLabel.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-10)
                make.bottom.equalToSuperview().offset(-10)
            }
        }
    }
    
    
}
