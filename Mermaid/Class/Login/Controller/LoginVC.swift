//
//  LoginVC.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2018/3/22.
//  Copyright © 2018年 蔡晓东. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {

    private var nameInputView:UITextField!
    private var passInputView:UITextField!
    private var confirmBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }

    func setupUI() {
        let nameRect = CGRect(x: 100, y: 100, width: 100, height: 30)
        nameInputView = UITextField(frame: nameRect)
        self.view.addSubview(nameInputView)
        
        
        let passRect = CGRect(x: 100, y: 150, width: 100, height: 30)
        passInputView = UITextField(frame: passRect)
        self.view.addSubview(passInputView)
        
        let btnRect = CGRect(x: 100, y: 200, width: 100, height: 30)
        confirmBtn = UIButton(frame: btnRect)
        self.view.addSubview(confirmBtn)
        confirmBtn.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }
    
    @objc func confirmAction() {
        let name = nameInputView.text!
        let pass = passInputView.text!
        if name.isEmpty {
            MyTool.showToast(str: "用户名为空")
            return
        }
        if pass.isEmpty {
            MyTool.showToast(str: "密码为空")
            return
        }
        if name != UserAccountInfo().userName || pass != UserAccountInfo().password {
            MyTool.showToast(str: "用户名或密码不正确")
            return
        }
        MyTool.writeValueForKey(value: "id021-110", key: UserDefaultKeys.LoginInfo().userId)
        AppDelegate.shared().checkLogin()
    }
}
