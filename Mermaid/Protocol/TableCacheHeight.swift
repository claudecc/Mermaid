//
//  TableCacheHeight.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/27.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit

// MARK: - 组列表缓存

protocol TableSectionCacheHeight {
//    var sectionHeights: [[CGFloat]] { get set }
//    func updateSectionCell(height: CGFloat, indexPath: IndexPath)
    /// 获取缓存的高度
    func getSectionCellHeight(tableView: UITableView, indexPath: IndexPath) -> CGFloat
//    func calculateSectionCellHeight(tableView: UITableView, indexPath: IndexPath) -> CGFloat
    /// 清除indexPath缓存高度
    func clearSectionCellHeight(indexPath: IndexPath)
    /// 清除所有缓存高度
    func clearAllSectionCellHeight()
}

private var tableSectionCacheHeightKey: Void?
extension TableSectionCacheHeight where Self: UIViewController {
    var sectionHeights: [[CGFloat]] {
        set { objc_setAssociatedObject(self, &tableSectionCacheHeightKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
        get { return objc_getAssociatedObject(self, &tableSectionCacheHeightKey) as? [[CGFloat]] ?? [] }
    }
    
    /// 更新缓存高度（已有的，或添加一个新的）
    func updateSectionCell(height: CGFloat, indexPath: IndexPath) {
        var caches = sectionHeights
        guard indexPath.section >= 0,
              indexPath.section <= caches.count,
              indexPath.row >= 0 else {
            return
        }
        var section: [CGFloat] = indexPath.section < caches.count
            ? caches[indexPath.section]
            : []
        guard indexPath.row <= section.count else {
            return
        }
        if indexPath.row < section.count {
            section[indexPath.row] = height
        } else {
            section.append(height)
        }
        if indexPath.section < caches.count {
            caches[indexPath.section] = section
        } else {
            caches.append(section)
        }
        sectionHeights = caches
    }
    
    /// 需要先在cellForItemAt中赋值数据
    func getSectionCellHeight(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        if indexPath.section < sectionHeights.count {
            let section = sectionHeights[indexPath.section]
            if indexPath.row < section.count {
                let height = section[indexPath.row]
                if height > 0 {
                    return height
                }
            }
        }
        let height = calculateSectionCellHeight(tableView: tableView, indexPath: indexPath)
        updateSectionCell(height: height, indexPath: indexPath)
        return height
    }
    
    /// 需要先在cellForItemAt中赋值数据
    func calculateSectionCellHeight(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        XDLog.log("indexPath: \(indexPath.section):\(indexPath.row)")
        guard let dataSource = tableView.dataSource else {
            return .zero
        }
        let width: CGFloat = tableView.frame.width
        let calculateCell = dataSource.tableView(tableView, cellForRowAt: indexPath)
        let maxSize = CGSize(width: width, height: tableView.frame.height)
        let size = calculateCell.contentView.systemLayoutSizeFitting(maxSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return size.height
    }
    
    /// 清除indexPath缓存高度
    func clearSectionCellHeight(indexPath: IndexPath) {
        updateSectionCell(height: 0, indexPath: indexPath)
    }
    
    /// 清除所有缓存高度
    func clearAllSectionCellHeight() {
        sectionHeights = []
    }
}

// MARK: - 单列表缓存

protocol TableCacheHeight {
//    var sectionHeights: [[CGFloat]] { get set }
//    func updateSectionCell(height: CGFloat, indexPath: IndexPath)
    /// 获取缓存的高度
    func getCellHeight(tableView: UITableView, indexPath: IndexPath) -> CGFloat
//    func calculateSectionCellHeight(tableView: UITableView, indexPath: IndexPath) -> CGFloat
    /// 清除indexPath缓存高度
    func clearCellHeight(indexPath: IndexPath)
    /// 清除所有缓存高度
    func clearAllCellHeight()
}

private var tableCacheHeightKey: Void?
extension TableCacheHeight where Self: UIViewController {
    var cacheHeights: [CGFloat] {
        set { objc_setAssociatedObject(self, &tableCacheHeightKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
        get { return objc_getAssociatedObject(self, &tableCacheHeightKey) as? [CGFloat] ?? [] }
    }
    
    /// 更新缓存高度（已有的，或添加一个新的）
    func updateCell(height: CGFloat, indexPath: IndexPath) {
        var caches = cacheHeights
        guard indexPath.row >= 0,
              indexPath.row <= caches.count else {
            return
        }
        if indexPath.row < caches.count {
            caches[indexPath.row] = height
        } else {
            caches.append(height)
        }
        cacheHeights = caches
    }
    
    /// 需要先在cellForItemAt中赋值数据
    func getCellHeight(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        if indexPath.row < cacheHeights.count {
            let height = cacheHeights[indexPath.row]
            if height > 0 {
                return height
            }
        }
        let height = calculateCellHeight(tableView: tableView, indexPath: indexPath)
        updateCell(height: height, indexPath: indexPath)
        return height
    }
    
    /// 需要先在cellForItemAt中赋值数据
    func calculateCellHeight(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        XDLog.log("indexPath: \(indexPath.section):\(indexPath.row)")
        guard let dataSource = tableView.dataSource else {
            return .zero
        }
        let width: CGFloat = tableView.frame.width
        let calculateCell = dataSource.tableView(tableView, cellForRowAt: indexPath)
        let maxSize = CGSize(width: width, height: tableView.frame.height)
        let size = calculateCell.contentView.systemLayoutSizeFitting(maxSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return size.height
    }
    
    /// 清除indexPath缓存高度
    func clearCellHeight(indexPath: IndexPath) {
        updateCell(height: 0, indexPath: indexPath)
    }
    
    /// 清除所有缓存高度
    func clearAllCellHeight() {
        cacheHeights = []
    }
}
