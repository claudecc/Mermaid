//
//  CalendarVC.swift
//  Mermaid
//
//  Created by caixiaodong on 2021/7/22.
//  Copyright © 2021 claudechoi. All rights reserved.
//

import UIKit

class CalendarVC: BaseVC {

    let type: Int
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: Int) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch type {
        case 0:
            setupCustomizeUI()
        case 1:
            setupAirbnbUI()
        case 2:
            setupCVUI()
        default:
            print("do nothing")
        }
    }

    func setupCustomizeUI() {
        let calendarView = XDCalendarView()
        self.view.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view)
        }
    }
    
    func setupAirbnbUI() {
        let calendarView = AirbnbCalendarView()
        self.view.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
//            make.top.left.right.equalTo(self.view)
            make.edges.equalToSuperview()
        }
    }
    
    func setupCVUI() {
        let calendarView = CVShowCalendarView()
        self.view.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
//            make.top.left.right.equalTo(self.view)
            make.edges.equalToSuperview()
        }
    }
    
}
