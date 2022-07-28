//
//  UIButtonExtension.swift
//  SwiftLearning
//
//  Created by caixiaodong on 2020/3/31.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

import UIKit

struct ButtonExtensionKey {
    static var touchActionKey : String = "touchActionKey"
}

typealias ButtonTouchClosure = (UIButton)->()

extension UIButton {
    
    public enum kImagePosition : Int {
        //图片在左，文字在右
        case left
        //图片在右，文字在左
        case right
        //图片在上，文字在下
        case top
        //图片在下，文字在上
        case bottom
    }
    
    func setImagePosition(position:kImagePosition, spacing:CGFloat) {
        
        guard let font = self.titleLabel?.font else {
            return
        }
        
        if self.isSelected {
            self.setTitle(self.currentTitle, for: .selected)
            self.setImage(self.currentImage, for: .selected)
        } else {
            self.setTitle(self.currentTitle, for: .normal)
            self.setImage(self.currentImage, for: .normal)
        }
        
        var imageWidth:CGFloat = 0.0
        var imageHeight:CGFloat = 0.0
        if self.currentImage != nil {
            if let image = self.imageView?.image {
                imageWidth = image.size.width
                imageHeight = image.size.height
            }
        }
        
        let maxSize = CGSize(width: 0, height: font.lineHeight)
        let attributes = [NSAttributedString.Key.font: font]
        var labelRect = CGRect.zero
        if let text = self.titleLabel?.text {
            labelRect = text.boundingRect(with: maxSize, options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attributes as [NSAttributedString.Key : Any], context: nil)
        }
        let labelWidth:CGFloat = labelRect.size.width
        let labelHeight:CGFloat = labelRect.size.height
        
        
        let imageOffsetX:CGFloat = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
        let imageOffsetY:CGFloat = imageHeight / 2 + spacing / 2;//image中心移动的y距离
        let labelOffsetX:CGFloat = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
        let labelOffsetY:CGFloat = labelHeight / 2 + spacing / 2;//label中心移动的y距离
        
        let tempWidth:CGFloat = max(labelWidth, imageWidth);
        let changedWidth:CGFloat = labelWidth + imageWidth - tempWidth;
        let tempHeight:CGFloat = max(labelHeight, imageHeight);
        let changedHeight:CGFloat = labelHeight + imageHeight + spacing - tempHeight;
        
        #warning("cxd need to be tested")
        switch position {
        case .left:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: spacing/2)
        case .right:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + spacing/2, bottom: 0, right: -(labelWidth + spacing/2))
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageWidth + spacing/2), bottom: 0, right: imageWidth + spacing/2)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: spacing/2)
        case .top:
            self.imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsets(top: labelOffsetY, left: -labelOffsetX, bottom: -labelOffsetY, right: labelOffsetX)
            self.contentEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: -changedWidth/2, bottom: changedHeight-imageOffsetY, right: -changedWidth/2)
        case .bottom:
            self.imageEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsets(top: -labelOffsetY, left: -labelOffsetX, bottom: labelOffsetY, right: labelOffsetX)
            self.contentEdgeInsets = UIEdgeInsets(top: changedHeight-imageOffsetY, left: -changedWidth/2, bottom: imageOffsetY, right: -changedWidth/2)
//        default:
//            print("none position")
        }
        
    }
    
    func addTouchAction(_ action:ButtonTouchClosure) {
        self.addTarget(self, action: #selector(clickAction(sender:)), for: .touchUpInside)
        objc_setAssociatedObject(self, &ButtonExtensionKey.touchActionKey, action as AnyObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    @objc private func clickAction(sender:UIButton) {
        if let action:ButtonTouchClosure = objc_getAssociatedObject(self, &ButtonExtensionKey.touchActionKey) as? ButtonTouchClosure {
            action(self)
        }
    }
    
}
