//
//  UIImageViewExtension.swift
//  SwiftLearning
//
//  Created by caixiaodong on 2020/4/1.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func xd_setImage(_ url:String?) {
        self.xd_setImage(url, nil)
    }
    
    func xd_setImage(_ url:String?, _ placeholder:UIImage?) {
        guard let url = url else { return }
        if url.isEmpty {
            return
        }
        let imageUrl = URL(string: url)
        self.kf.setImage(with: imageUrl, placeholder: placeholder)
    }
    
    func xd_setCircleImage(_ url:String?, _ placeholder:UIImage?) {
        guard let url = url else { return }
        if url.isEmpty {
            return
        }
        let imageUrl = URL(string: url)
        self.kf.setImage(with: imageUrl, placeholder: placeholder, options: .none, progressBlock: nil) { (Result) in
            
        }
    }
    
}
