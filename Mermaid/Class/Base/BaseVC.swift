//
//  BaseVC.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2018/3/21.
//  Copyright © 2018年 蔡晓东. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        }
        
        if (self.navigationController?.viewControllers.count ?? 0) > 1 {
            self.hidesBottomBarWhenPushed = true
            self.createBackButton()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createBackButton() {
        let item = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItem = item
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
