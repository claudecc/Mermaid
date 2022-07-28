//
//  UITableViewCell+Extension.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/28.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit

extension UITableViewCell {
    var indexPath: IndexPath? {
        var next = next
        while next != nil {
            if let tableView = next as? UITableView {
                return tableView.indexPath(for: self)
            }
            next = next?.next
        }
        return nil
    }
}
