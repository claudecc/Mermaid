//
//  UICollectionViewCell+Extension.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/28.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    var indexPath: IndexPath? {
        var next = next
        while next != nil {
            if let collectionView = next as? UICollectionView {
                return collectionView.indexPath(for: self)
            }
            next = next?.next
        }
        return nil
    }
}
