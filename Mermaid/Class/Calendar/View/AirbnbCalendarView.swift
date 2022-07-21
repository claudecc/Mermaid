//
//  AirbnbCalendarView.swift
//  Mermaid
//
//  Created by caixiaodong on 2021/7/23.
//  Copyright © 2021 claudechoi. All rights reserved.
//

import UIKit
import HorizonCalendar

class AirbnbCalendarView: UIView {

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
        let calendarView = CalendarView(initialContent: makeContent())
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
          calendarView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
          calendarView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
          calendarView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
          calendarView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    private func makeContent() -> CalendarViewContent {
      let calendar = Calendar.current

      let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
      let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!

      return CalendarViewContent(
        calendar: calendar,
        visibleDateRange: startDate...endDate,
        monthsLayout: .horizontal(options: HorizontalMonthsLayoutOptions()))
    }

}
