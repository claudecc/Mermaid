//
//  TestVC.swift
//  SwiftLearning
//
//  Created by claudechoi on 2019/4/16.
//  Copyright © 2019 蔡晓东. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON

class TestVC: BaseVC,TestViewProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    
    func setupUI() {
        self.title = "Test"
        let testView = TestView()
        self.view.addSubview(testView)
        testView.testDelegate = self
        testView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(80)
            make.left.equalTo(self.view).offset(20)
            make.width.height.equalTo(200)
        }
        
        XDNetwork.shareNetwork.GET(urlString: XDInterface.bannerUrl, parameters: nil, success: { (response) in
            let result = JSON(response)
            print("message:\(result["message"])")
        }) { (error, text) in
            print(text)
        }
    }
    
    class func classFucntion() {
        
    }
    
    func TestViewProtocolAction() {
        print("测试代理")
    }
    
}
