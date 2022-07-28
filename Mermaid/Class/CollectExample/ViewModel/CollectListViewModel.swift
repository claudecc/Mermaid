//
//  CollectListViewModel.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/22.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import Foundation

extension CollectListViewModel {
    enum SectionType: Equatable {
        case userCard
        case reduce
        case list
    }
    typealias Section = SectionsModel<SectionType, Any>
}


class CollectListViewModel {
    var data: [Section] = []
    
    func loadData() {
        let cardList: [Any] = (1...10).map({ CollectCardModel(title: "\($0) UserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContent") })
        let list: [Any] = (1...10).map({ CollectListModel(title: "item \($0)", des: "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent") })
        let reduceList: [Any] = (1...10).map({ CollectReduceModel(title: "\($0) contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent") })
        data = [
            SectionsModel(identifier: SectionType.userCard, items: cardList),
            SectionsModel(identifier: SectionType.list, items: list),
            SectionsModel(identifier: SectionType.reduce, items: reduceList)
        ]
    }
    
}
