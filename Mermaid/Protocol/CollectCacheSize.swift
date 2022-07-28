//
//  CollectCacheSize.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/22.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit

protocol CollectCacheSize {
//    var cacheSizes: [[CGSize]] { get set }
//    func updateCell(size: CGSize, indexPath: IndexPath)
    /// 获取缓存
    func getCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize
//    func calculateCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize
    /// 清除indexPath缓存
    func clearCellSize(indexPath: IndexPath)
    /// 清除所有缓存
    func clearAllCellSize()
}

private var collectCacheSizeKey: Void?
extension CollectCacheSize where Self: UIViewController {
    var cacheSizes: [[CGSize]] {
        set { objc_setAssociatedObject(self, &collectCacheSizeKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
        get { return objc_getAssociatedObject(self, &collectCacheSizeKey) as? [[CGSize]] ?? [] }
    }
    
    /// 更新缓存（已有的，或添加一个新的）
    func updateCell(size: CGSize, indexPath: IndexPath) {
        var caches = cacheSizes
        guard indexPath.section >= 0,
              indexPath.section <= caches.count,
              indexPath.item >= 0 else {
            return
        }
        var section: [CGSize] = indexPath.section < caches.count
            ? caches[indexPath.section]
            : []
        guard indexPath.item <= section.count else {
            return
        }
        if indexPath.item < section.count {
            section[indexPath.item] = size
        } else {
            section.append(size)
        }
        if indexPath.section < caches.count {
            caches[indexPath.section] = section
        } else {
            caches.append(section)
        }
        cacheSizes = caches
    }
    
    /// 需要先在cellForItemAt中赋值数据
    func getCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        if indexPath.section < cacheSizes.count {
            let section = cacheSizes[indexPath.section]
            if indexPath.item < section.count {
                let size = section[indexPath.item]
                if size != .zero {
                    return size
                }
            }
        }
        let size = calculateCellSize(collectionView: collectionView, indexPath: indexPath)
        updateCell(size: size, indexPath: indexPath)
        return size
    }
    
    /// 需要先在cellForItemAt中赋值数据
    func calculateCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        XDLog.log("indexPath: \(indexPath.section):\(indexPath.row)")
        guard let dataSource = collectionView.dataSource else {
            return .zero
        }
        let width: CGFloat = collectionView.frame.width
        let calculateCell = dataSource.collectionView(collectionView, cellForItemAt: indexPath)
        let maxSize = CGSize(width: width, height: collectionView.frame.height)
        // 横轴按maxSize赋值，竖轴动态计算
        let size = calculateCell.contentView.systemLayoutSizeFitting(maxSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return size
    }
    
    /// 清除indexPath缓存
    func clearCellSize(indexPath: IndexPath) {
        updateCell(size: .zero, indexPath: indexPath)
    }
    
    /// 清除所有缓存
    func clearAllCellSize() {
        cacheSizes = []
    }
}
