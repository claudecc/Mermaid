//
//  UITextFieldExtension.swift
//  SwiftLearning
//
//  Created by caixiaodong on 2020/4/1.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

import UIKit

struct TextFieldExtensionKey {
    static var textChangeActionKey : String = "textChangeActionKey"
}

typealias TextChangeActionClosure = (UITextField)->()

extension UITextField {
    func setPlaceholder(_ text:String, _ color:UIColor) {
        self.setPlaceholder(text, color, .left)
    }
    
    func setPlaceholder(_ text:String, _ color:UIColor, _ align:NSTextAlignment) {
        
        let att = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: text.count)
        // 颜色
        att.addAttributes([NSAttributedStringKey.foregroundColor : color], range: range)
        // 对齐
        let style = NSMutableParagraphStyle()
        style.alignment = align
        att.addAttributes([NSAttributedStringKey.paragraphStyle : style], range: range)
        
        self.attributedPlaceholder = att
    }
    
    func xd_addTextChangedAction(_ action:TextChangeActionClosure) {
        self.addTarget(self, action: #selector(textChangedAction(_:)), for: .editingChanged)
        objc_setAssociatedObject(self, &TextFieldExtensionKey.textChangeActionKey, action as AnyObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    @objc private func textChangedAction(_ sender:UITextField) {
        if let action:TextChangeActionClosure = objc_getAssociatedObject(self, &TextFieldExtensionKey.textChangeActionKey) as? TextChangeActionClosure {
            action(self)
        }
    }
    
}
