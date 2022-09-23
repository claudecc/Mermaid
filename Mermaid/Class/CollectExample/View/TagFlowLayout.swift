//
//  TagFlowLayout.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/8/25.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit

class TapTagFlowLayout: UICollectionViewFlowLayout {
    enum Align {
        case left
        case center
        case right
    }
    
    var alignType: Align = .center
    
    private var currentLineWidth: CGFloat = 0
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            
        let layoutAttributes_super : [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect) ?? [UICollectionViewLayoutAttributes]()
        let layoutAttributes:[UICollectionViewLayoutAttributes] = NSArray(array: layoutAttributes_super, copyItems:true)as! [UICollectionViewLayoutAttributes]
        var layoutAttributes_t : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        
        var currentLine: Int = 1
        
        for index in 0..<layoutAttributes.count {
            let currentAttr = layoutAttributes[index]
            let previousAttr = index == 0 ? nil : layoutAttributes[index-1]
            let nextAttr = index + 1 == layoutAttributes.count ? nil : layoutAttributes[index+1]
            
            layoutAttributes_t.append(currentAttr)
            currentLineWidth += currentAttr.frame.size.width
            
            let previousY :CGFloat = previousAttr == nil ? 0 : previousAttr!.frame.maxY
            let currentY :CGFloat = currentAttr.frame.maxY
            let nextY:CGFloat = nextAttr == nil ? 0 : nextAttr!.frame.maxY
            
            if currentY != previousY && currentY != nextY {
                if currentAttr.representedElementKind == UICollectionView.elementKindSectionHeader {
                    layoutAttributes_t.removeAll()
                    currentLineWidth = 0.0
                } else if currentAttr.representedElementKind == UICollectionView.elementKindSectionFooter {
                    layoutAttributes_t.removeAll()
                    currentLineWidth = 0.0
                } else {
                    self.setCellFrame(with: layoutAttributes_t)
                    layoutAttributes_t.removeAll()
                    currentLineWidth = 0.0
                }
                currentLine += 1
            } else if currentY != nextY {
                self.setCellFrame(with: layoutAttributes_t)
                layoutAttributes_t.removeAll()
                currentLineWidth = 0.0
                currentLine += 1
            }
        }
        return layoutAttributes
    }
    
    func setCellFrame(with layoutAttributes : [UICollectionViewLayoutAttributes]) {
        var nowWidth : CGFloat = 0.0
        switch alignType {
        case .left:
            nowWidth = self.sectionInset.left
            for attributes in layoutAttributes {
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.minimumInteritemSpacing
            }
            
        case .center:
            nowWidth = (self.collectionView!.frame.size.width - currentLineWidth - (CGFloat(layoutAttributes.count - 1) * minimumInteritemSpacing)) / 2
            for attributes in layoutAttributes {
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.minimumInteritemSpacing
            }
            
        case .right:
            nowWidth = self.collectionView!.frame.size.width - self.sectionInset.right
            for var index in 0 ..< layoutAttributes.count {
                index = layoutAttributes.count - 1 - index
                let attributes = layoutAttributes[index]
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth - nowFrame.size.width
                attributes.frame = nowFrame
                nowWidth = nowWidth - nowFrame.size.width - minimumInteritemSpacing
            }
        }
    }
}
