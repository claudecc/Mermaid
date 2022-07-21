//
//  DifferenceListModel.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/21.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import Foundation
import DifferenceKit

struct DifferenceListModel: Codable, Differentiable {
    var id: Int
    var name: String
    
    var differenceIdentifier: Int { id }
    func isContentEqual(to source: DifferenceListModel) -> Bool {
        id == source.id
    }
}
