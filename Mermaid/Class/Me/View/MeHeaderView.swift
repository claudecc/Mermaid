//
//  MeHeaderView.swift
//  SwiftLearning
//
//  Created by claudechoi on 2018/4/13.
//  Copyright © 2018年 蔡晓东. All rights reserved.
//

import UIKit

enum MeHeaderViewEvent {
    case showLogin
    case showProfile
}

protocol MeHeaderViewProtocol : NSObjectProtocol {
    func meHeaderViewProtocol(view:MeHeaderView,event:MeHeaderViewEvent,msg:AnyObject)
}

class MeHeaderView: UIView {
    
    var delegate:MeHeaderViewProtocol?
    
    private var headView:UIImageView?
    private var nameLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initializeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeUI() {
        self.backgroundColor = .cyan
        
        
    }
    
    func clickHead() {
//        delegate?.meHeaderViewProtocol(view: self, event: .showLogin, msg: nil)
    }
    
}
