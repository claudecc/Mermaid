//
//  DateItemModel.swift
//  Mermaid
//
//  Created by caixiaodong on 2021/7/22.
//  Copyright © 2021 claudechoi. All rights reserved.
//

import Foundation

struct DateItemModel {
    var year: Int
    var month: Int
    var day: Int
    /// 周几
    var weekDay: Int
    var isCurrentMonth: Bool = false
    var isToday: Bool = false
    var isAcc: Bool = false
    var isSelect: Bool = false
}
