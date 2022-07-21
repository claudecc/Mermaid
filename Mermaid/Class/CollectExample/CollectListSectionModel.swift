//
//  CollectListSectionModel.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/21.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import Foundation

struct CollectListSectionModel<ID: Equatable, ITEM: Any> {
    var identifier: ID
    var items: [ITEM] = []
}
