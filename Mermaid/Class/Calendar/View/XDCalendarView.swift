//
//  XDCalendarView.swift
//  Mermaid
//
//  Created by caixiaodong on 2021/7/22.
//  Copyright © 2021 claudechoi. All rights reserved.
//
// https://cloud.tencent.com/developer/article/1187112

import UIKit

extension XDCalendarView {
    struct UISet {
        static var oneWeekH: CGFloat = 50
        static var oneMonthH: CGFloat = 200
    }
}

class XDCalendarView: UIView {

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        self.layer.borderWidth = 1
    }
    
    func setOneWeekStyle() {
        self.snp.makeConstraints { make in
            make.height.equalTo(UISet.oneWeekH)
        }
    }

    func setOneMonthStyle() {
        self.snp.makeConstraints { make in
            make.height.equalTo(UISet.oneMonthH)
        }
    }

}
