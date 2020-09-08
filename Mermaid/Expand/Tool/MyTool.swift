//
//  MyTool.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2018/3/22.
//  Copyright © 2018年 蔡晓东. All rights reserved.
//

import UIKit

struct UserDefaultKeys {
    // 账户信息
    struct AccountInfo {
        let userName = "userName"
        let password = "password"
    }
    // 登录信息
    struct LoginInfo {
        let token = "token"
        let userId = "userId"
    }
    // 配置信息
    struct SettingInfo {
        let font = "font"
        let backgroundImage = "backgroundImage"
    }
}

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
/**
 测试账户信息
 */
struct UserAccountInfo {
    let userName = "Claude"
    let password = "123456"
}

struct PointCalculate {
    var maxX = 10.0
    func isSafeValue(x:Double) -> Bool {
        return (x >= 0) && (x < self.maxX);
    }
}

class MyTool: NSObject {
    
    // 是否登录
    class func isLogin () -> Bool {
        return true
        let userId : String? = MyTool.readValueForKey(key: UserDefaultKeys.LoginInfo().userId) as? String
        if userId != nil {
            return true
        }
        return false
    }
    
    // 写入userDefault
    class func writeValueForKey(value:Any?, key:String?) {
        if let saveValue = value, let saveKey = key {
            let userDefault = UserDefaults.standard
            userDefault.set(saveValue, forKey: saveKey)
        }
    }
    
    // 读取userDefault
    class func readValueForKey(key:String?) -> Any? {
        if let readKey = key {
            let userDefault = UserDefaults.standard
            return userDefault.object(forKey: readKey)
        } else {
            return nil
        }
    }
    
    // 删除userDefault
    class func removeValueForKey(key:String?) {
        if let readKey = key {
            let userDefault = UserDefaults.standard
            userDefault.removeObject(forKey: readKey)
        }
    }
    
    // toast
    class func showToast(str:String?) {
        if let showStr = str {
            let window = UIApplication.shared.keyWindow!
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 0))
            label.text = showStr
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 14)
            label.backgroundColor = UIColor(white: 0, alpha: 0.6)
            label.layer.cornerRadius = 6
            label.layer.masksToBounds = true
            label.sizeToFit()
            label.center = window.center
            label.alpha = 0
            window.addSubview(label)
            
            UIView.animate(withDuration: 0.2, animations: {
                label.alpha = 1
            }, completion: { (isDone:Bool) in
                UIView.animate(withDuration: 0.2, delay: 3, options: .curveEaseInOut, animations: {
                    label.alpha = 0
                }, completion: { (isDone:Bool) in
                    label.removeFromSuperview()
                })//
                
            })//
            
        }
    }
    
    func dateToTime(seconds:TimeInterval) -> String {
        print("\(seconds)") // 1462861373.10082
        let confromTimesp = NSDate.init(timeIntervalSince1970: seconds)
        print("\(confromTimesp)") //2016-05-10 06:22:53 +0000 这个是UTC时间，没算时区
        let dateFormate = DateFormatter.init()
        dateFormate.dateFormat = "MM-dd HH:mm" //mm必须是小写
        let time = dateFormate.string(from: confromTimesp as Date)
        print("\(time)") // 05-10 14:22
        return time;
    }
    
    // 递归找最上面的VC
    @objc class func topViewController() -> UIViewController? {
        return self.topViewControllerWithRootViewController(viewController: self.getCurrentWindow()?.rootViewController)
    }
    
    @objc private class func topViewControllerWithRootViewController(viewController:UIViewController?) -> UIViewController? {
        if viewController == nil {
            return nil
        }
        
        if viewController?.presentedViewController != nil {
            return self.topViewControllerWithRootViewController(viewController:viewController?.presentedViewController!)
        }
        else if viewController?.isKind(of: UITabBarController.self) == true {
            return self.topViewControllerWithRootViewController(viewController:(viewController as! UITabBarController).selectedViewController)
        }
        else if viewController?.isKind(of: UINavigationController.self) == true {
            return self.topViewControllerWithRootViewController(viewController:(viewController as! UINavigationController).visibleViewController)
        }
        else {
            return viewController;
        }
    }
    
    // 找到当前显示的window
    private class func getCurrentWindow() -> UIWindow? {
        // 找到当前显示的UIWindow
        var window: UIWindow? = UIApplication.shared.keyWindow
        /**
         window有一个属性：windowLevel
         当 windowLevel == UIWindowLevelNormal 的时候，表示这个window是当前屏幕正在显示的window
         */
        if window?.windowLevel != UIWindowLevelNormal {
            for tempWindow in UIApplication.shared.windows {
                if tempWindow.windowLevel == UIWindowLevelNormal {
                    window = tempWindow
                    break
                }
            }
        }
        return window
    }
    
    
}
