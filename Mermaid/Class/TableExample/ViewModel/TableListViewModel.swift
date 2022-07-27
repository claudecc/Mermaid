//
//  TableListViewModel.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/27.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import Foundation

extension TableListViewModel {
    enum SectionType: Equatable {
        case user
        case card
        case list
    }
    typealias Section = SectionsModel<SectionType, Any>
}

class TableListViewModel {
    private(set) var data: [Section] = []
    
    func loadData() {
        let userList: [Any] = (1...10).map({ TableListUserModel(title: "\($0) UserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContent") })
        let list: [Any] = (1...20).map({ TableListModel(title: "item \($0)", des: "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent") })
        let cardList: [Any] = (1...15).map({ TableListCardModel(title: "\($0) contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent") })
        data = [
            SectionsModel(identifier: SectionType.user, items: userList),
            SectionsModel(identifier: SectionType.list, items: list),
            SectionsModel(identifier: SectionType.card, items: cardList)
        ]
    }
    
}
