//
//  TapVisualEffectView.swift
//  TapBooster
//
//  Created by caixiaodong on 2021/6/25.
//

import UIKit

open class TapVisualEffectView: UIVisualEffectView {
    /// 模糊等级 （0 ~ 1）
    open var blurLevel: Float = 1 {
        didSet {
            self.resumeAnimation()
            
            var blurEffect: UIVisualEffect
            if let effect = self.effect {
                blurEffect = effect
            } else {
                blurEffect = UIBlurEffect(style: .extraLight)
            }
            
            self.effect = nil
            
            UIView.animate(withDuration: TimeInterval(1 - blurLevel)) {
                self.effect = blurEffect
            }
            
            self.pauseAnimation(delay: 0.3)
        }
    }

    fileprivate let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()
    
    open var colorTint: UIColor? {
        get { return _value(forKey: "colorTint") as? UIColor }
        set { _setValue(newValue, forKey: "colorTint") }
    }
    
    /// 默认 1
    open var colorTintAlpha: CGFloat {
        get { return (_value(forKey: "colorTintAlpha") as? CGFloat) ?? 0 }
        set { _setValue(newValue, forKey: "colorTintAlpha") }
    }
    
    /// 默认 20
    open var blurRadius: CGFloat {
        get { return (_value(forKey: "blurRadius") as? CGFloat) ?? 0 }
        set { _setValue(newValue, forKey: "blurRadius") }
    }
    
    /// 默认 1.0
    open var scale: CGFloat {
        get { return (_value(forKey: "scale") as? CGFloat) ?? 0 }
        set { _setValue(newValue, forKey: "scale") }
    }
    
    override public init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        
        prepare()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        prepare()
    }
    
    fileprivate func prepare() {
        scale = 1
        colorTintAlpha = 0.5
        blurRadius = 20
    }
}

extension UIView {
    /// 暂停动画
    fileprivate func pauseAnimation(delay: Double) {
        let time = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, time, 0, 0, 0, { _ in
            let layer = self.layer
            let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
            layer.speed = 0
            layer.timeOffset = pausedTime
        })
        
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
    }
    
    /// 继续动画
    fileprivate func resumeAnimation() {
        let pausedTime = layer.timeOffset
        
        layer.speed = 1.0
        layer.timeOffset = 0
        layer.beginTime = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    }
}

extension TapVisualEffectView {
    fileprivate func _value(forKey key: String) -> Any? {
        return blurEffect.value(forKeyPath: key)
    }
    
    fileprivate func _setValue(_ value: Any?, forKey key: String) {
        blurEffect.setValue(value, forKeyPath: key)
        self.effect = blurEffect
    }
}
