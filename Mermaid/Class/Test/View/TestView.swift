//
//  TestView.swift
//  SwiftLearning
//
//  Created by claudechoi on 2019/4/16.
//  Copyright © 2019 蔡晓东. All rights reserved.
//

import UIKit
import Kingfisher

protocol TestViewProtocol : class,NSObjectProtocol { // class表明当前协议只适用于类
    func TestViewProtocolAction()
}

class TestView: UIView {

    weak var testDelegate:TestViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        let imageView = UIImageView()
        imageView.frame = CGRect.init(x: 40, y: 100, width: 200, height: 200)
        self.addSubview(imageView)
        let url = URL(string: "http://img1.nz86.com/upload/picture/system/10/82/64/61773321317560495.jpg")
//        imageView.kf.setImage(with: url)
        imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
            
        }
        imageView.isUserInteractionEnabled = true
        let ges = UITapGestureRecognizer(target: self, action: #selector(TestView.imageViewTapAction))
        imageView.addGestureRecognizer(ges)
        
    }
    
    @objc func imageViewTapAction() {
        if self.testDelegate != nil {
            if self.testDelegate!.responds(to: Selector("TestViewProtocolAction")) {
                self.testDelegate?.TestViewProtocolAction()
            }
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//    }
}
