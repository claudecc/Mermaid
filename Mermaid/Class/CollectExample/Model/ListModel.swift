//
//  ListModel.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/21.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import Foundation

struct ListModel<T: Codable> {
    var list: [T] = []
    var total: Int = 0
    var count: Int { list.count }
    var isEnd: Bool { count >= total }
}
