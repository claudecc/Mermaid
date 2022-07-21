//
//  CVShowCalendarView.swift
//  Mermaid
//
//  Created by caixiaodong on 2021/7/23.
//  Copyright © 2021 claudechoi. All rights reserved.
//

import UIKit
import CVCalendar

class CVShowCalendarView: UIView {

    lazy var menuView: CVCalendarMenuView = {
        let menuView = CVCalendarMenuView(frame: CGRect(x: 0, y: 0, width: 300, height: 15))
        menuView.menuViewDelegate = self
        return menuView
    }()
    
    lazy var calendarView: CVCalendarView = {
        let calendarView = CVCalendarView(frame: CGRect(x: 0, y: 20, width: 300, height: 450))
        calendarView.calendarAppearanceDelegate = self
        calendarView.animatorDelegate = self
        calendarView.calendarDelegate = self
        return calendarView
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    
    func setupUI() {
        self.layer.borderWidth = 1
        
        self.addSubview(menuView)
        self.addSubview(calendarView)
    }
    
}
