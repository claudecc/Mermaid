//
//  MeViewModel.swift
//  SwiftLearning
//
//  Created by caixiaodong on 2020/4/1.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

/*
 
 view <-> viewModel <-> controller
 
 controller create a viewModel(XXX)
 controller.viewModel do some thing
 
 view create with viewModel(XXX)
 view observe viewModel property
 
 
 */

import UIKit

class MeViewModel: NSObject {
    
    var userModel:NSObject?
    
    
    
    override init() {
        super.init()
        
    }
    
    
}
