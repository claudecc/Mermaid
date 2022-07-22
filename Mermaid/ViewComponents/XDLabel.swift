//
//  XDLabel.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/22.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit

class XDLabel: UILabel {

    var finalSize: CGSize?
    
    private var _text: String?
    
    override var text: String? {
        didSet {
            if _text != text {
                finalSize = nil
                _text = text
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        // 已知Label的size，则直接返回
        if let size = finalSize {
            return size
        }
//        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
        return super.intrinsicContentSize
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        finalSize = frame.size
    }
}
