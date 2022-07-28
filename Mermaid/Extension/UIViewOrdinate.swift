//
//  UIViewOrdinate.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2019/7/22.
//  Copyright © 2019 蔡晓东. All rights reserved.
//

import Foundation
import UIKit

private struct ViewExtensionKey {
    static var tap : String = "tap"
    static var press : String = "press"
    static var redPoint : String = "redPoint"
    // signal
    static var signalDict : String = "signalDict"
    static var callback : String = "callback"
    static var appendParaObj : String = "appendParaObj"
    static var sendToTopQueue : String = "sendToTopQueue"
}

typealias ViewGesClosure = (UIGestureRecognizer)->()

/*
 coordinate
 */
extension UIView {
    public var x : CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    public var y : CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    public var width : CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    public var height : CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    public var right : CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
    
    public var bottom : CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    
    public var origin : CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    public var size : CGSize {
        get {
            return self.frame.size
        }
        set {
            var frame = self.frame
            frame.size = newValue;
            self.frame = frame
        }
    }
    
}

/*
tool
*/
extension UIView {
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, true, UIScreen.main.scale)
        if self.responds(to: #selector(drawHierarchy(in:afterScreenUpdates:))) {
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        } else {
            let context = UIGraphicsGetCurrentContext()
            self.layer.render(in: context!)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func addTapAction(_ action:ViewGesClosure) {
        objc_setAssociatedObject(self, &ViewExtensionKey.tap, action as AnyObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        let ges = UITapGestureRecognizer(target: self, action: #selector(gesAction(_:)))
        self.addGestureRecognizer(ges)
        self.isUserInteractionEnabled = true
    }
    
    func addPressAction(_ action:ViewGesClosure) {
        objc_setAssociatedObject(self, &ViewExtensionKey.press, action as AnyObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        let ges = UILongPressGestureRecognizer(target: self, action: #selector(gesAction(_:)))
        self.addGestureRecognizer(ges)
        self.isUserInteractionEnabled = true
    }
    
    @objc func gesAction(_ ges:UIGestureRecognizer) {
        if ges.isKind(of: UITapGestureRecognizer.self) {
            if let action:ViewGesClosure = objc_getAssociatedObject(self, &ViewExtensionKey.tap) as? ViewGesClosure {
                action(ges)
            }
        } else if ges.isKind(of: UILongPressGestureRecognizer.self) {
            if let action:ViewGesClosure = objc_getAssociatedObject(self, &ViewExtensionKey.press) as? ViewGesClosure {
                action(ges)
            }
        }
    }
}

private let redPointTag:Int = 2020040117

/* red point */
extension UIView {
    
    public var isShowRedPoint : Bool {
        get {
            return objc_getAssociatedObject(self, &ViewExtensionKey.redPoint) as! Bool
        }
        set {
            objc_setAssociatedObject(self, &ViewExtensionKey.redPoint, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            var view = self.viewWithTag(redPointTag)
            if newValue {
                if view != nil {
                    view?.isHidden = false
                    return
                }
                
                view = UIView()
                view?.backgroundColor = UIColor.red
                view?.layer.cornerRadius = 5;
                view?.layer.borderWidth = 1
                view?.layer.borderColor = UIColor.red.cgColor
                view?.tag = redPointTag
                self.addSubview(view!)
                view?.snp.makeConstraints({ (make) in
                    make.top.equalToSuperview().offset(-5)
                    make.right.equalToSuperview().offset(5)
                    make.width.height.equalTo(10)
                })
                
            } else {
                if view != nil {
                    view?.removeFromSuperview()
                }
            }
        }
    }
    
}

typealias XDSignalObserveClosure = (AnyObject)->(AnyObject)
typealias XDSignalCallback = (AnyObject)->()

/*
 signal
 */
extension UIView {
    
    /*
    deliver event to top level
    */
    
    private var appendParaObj:AnyObject? {
        get {
            return nil
        }
        set {
            
        }
    }
    
    private var signalDict:Dictionary<String, XDSignalObserveClosure>? {
        get {
//            var dict:Dictionary = objc_getAssociatedObject(self, &ViewExtensionKey.signalDict) as! Dictionary<String, XDSignalObserveClosure>
//            if dict.isEmpty {
//                
//            }
            return nil
        }
    }
    
    private var callback:XDSignalCallback? {
        get {
            return nil
        }
        set {
            
        }
    }
    
    private var sendToTopQueue:OperationQueue? {
        get {
            return nil
        }
        set {
            
        }
    }
    
    
    /** sendSignalToTop used at the end */
    func sendSignalToTop(_ signal:String) -> UIView {
        
        return self
    }
    
    func appendObj(_ obj:AnyObject) -> UIView {
        
        return self
    }
    
    /** callback is a main thread */
    func appendCallback(_ callback:XDSignalCallback) -> UIView {
        
        return self
    }
    
    /** block is a child thread */
    func observeSignal(_ signal:String, _ block:XDSignalObserveClosure) {
        
    }
    
    private func isRegisterSignal() -> Bool {
        return false
    }
    
}
