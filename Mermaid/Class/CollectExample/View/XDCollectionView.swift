//
//  XDCollectionView.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/22.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit

class XDCollectionView: UICollectionView {
    
    private var cacheSizes: [[CGSize]] = []
    
    private func updateCell(size: CGSize, indexPath: IndexPath) {
        var section: [CGSize]
        if indexPath.section < cacheSizes.count {
            section = cacheSizes[indexPath.section]
        } else {
            section = []
        }
        if indexPath.row < section.count {
            section[indexPath.row] = size
        } else if indexPath.row == section.count {
            section.append(size)
        }
    }
    
    private func getCellSize(indexPath: IndexPath) -> CGSize? {
        guard indexPath.section < cacheSizes.count else {
            return nil
        }
        let section = cacheSizes[indexPath.section]
        guard indexPath.item < section.count else {
            return nil
        }
        return section[indexPath.item]
    }
    
    /// 需要先在cellForItemAt中赋值数据
    private func calculateCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        guard let dataSource = dataSource else {
            return .zero
        }
        let width: CGFloat = collectionView.frame.width
        let calculateCell = dataSource.collectionView(collectionView, cellForItemAt: indexPath)
        let maxSize = CGSize(width: width, height: collectionView.frame.height)
        let size = calculateCell.contentView.systemLayoutSizeFitting(maxSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return size
    }
}

extension XDCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let size = getCellSize(indexPath: indexPath) {
            return size
        }
        let size = calculateCellSize(collectionView: collectionView, indexPath: indexPath)
        updateCell(size: size, indexPath: indexPath)
        print("cxd - sizeForItemAt size: \(size)")
        return size
    }
}
