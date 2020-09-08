//
//  BaseTabbarVC.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2018/3/21.
//  Copyright © 2018年 蔡晓东. All rights reserved.
//

import UIKit

class BaseTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let homeVC = HomeVC()
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        homeVC.title = "Home"
        homeVC.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -3)
        let homeNav = BaseNavVC(rootViewController: homeVC)
        self.addChildViewController(homeNav)
        
        let meVC = MeVC()
        meVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        meVC.title = "Me"
        meVC.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -3)
        let meNav = BaseNavVC(rootViewController: meVC)
        self.addChildViewController(meNav)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
