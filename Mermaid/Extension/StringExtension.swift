//
//  StringExtension.swift
//  SwiftLearning
//
//  Created by caixiaodong on 2020/3/31.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

import UIKit

extension String {
    
    
    func getWidth(font:UIFont) -> CGFloat {
        let maxSize = CGSize(width: 0, height: font.lineHeight)
        let attributes = [NSAttributedString.Key.font: font]
        let width = self.boundingRect(with: maxSize, options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attributes, context: nil).width
        return width
    }
    
    var pure:String {
        get {
            if self.isEmpty {
                return ""
            }
            return self
        }
    }
    
    func removeBlank() -> String {
        if self.isEmpty {
            return ""
        }
        let temp = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return temp
    }
    
    func removeLeaderTailerBlank() -> String {
        if self.isEmpty {
            return ""
        }
        var temp = self.replacingOccurrences(of: " ", with: "")
        temp = temp.replacingOccurrences(of: "\r", with: "")
        temp = temp.replacingOccurrences(of: "\n", with: "")
        return temp
    }
    
}

extension NSAttributedString {
    
    func getSize(maxW:CGFloat) -> CGSize {
        let maxSize = CGSize(width: maxW, height: CGFloat(MAXFLOAT))
        let size = self.boundingRect(with: maxSize, options:NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).size
        return size
    }
    
}
