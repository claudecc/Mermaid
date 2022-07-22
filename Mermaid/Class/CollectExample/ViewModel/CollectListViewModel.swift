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
    typealias Section = CollectListSectionModel<SectionType, Any>
}


class CollectListViewModel {
    private(set) var data: [Section] = []
    
    func loadData() {
        let cardList: [Any] = [
            CollectCardModel(title: "UserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContent"),
            CollectCardModel(title: "UserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContent"),
            CollectCardModel(title: "UserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContent"),
            CollectCardModel(title: "UserContent"),
            CollectCardModel(title: "UserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContent"),
            CollectCardModel(title: "UserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContentUserContent"),
            CollectCardModel(title: "UserContent"),
        ]
        let list: [Any] = [
            CollectListModel(title: "item 1", des: "content"),
            CollectListModel(title: "item 2", des: "content"),
            CollectListModel(title: "item 3", des: "content"),
            CollectListModel(title: "item 1", des: "content"),
            CollectListModel(title: "item 2", des: "content"),
            CollectListModel(title: "item 3", des: "content"),
            CollectListModel(title: "item 1", des: "content"),
            CollectListModel(title: "item 2", des: "content"),
            CollectListModel(title: "item 3", des: "content"),
            CollectListModel(title: "item 1", des: "content"),
            CollectListModel(title: "item 2", des: "content"),
            CollectListModel(title: "item 3", des: "content"),
            CollectListModel(title: "item 1", des: "content"),
            CollectListModel(title: "item 2", des: "content"),
            CollectListModel(title: "item 3", des: "content"),
            CollectListModel(title: "item 4", des: "content"),
            CollectListModel(title: "item 5", des: "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent"),
            CollectListModel(title: "item 6", des: "content"),
        ]
        let reduceList: [Any] = [
            CollectReduceModel(title: "content"),
            CollectReduceModel(title: "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent"),
            CollectReduceModel(title: "content"),
            CollectReduceModel(title: "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent"),
            CollectReduceModel(title: "content"),
            CollectReduceModel(title: "content"),
            CollectReduceModel(title: "content"),
            CollectReduceModel(title: "content"),
            CollectReduceModel(title: "content"),
            CollectReduceModel(title: "content"),
            CollectReduceModel(title: "content"),
            CollectReduceModel(title: "content"),
            CollectReduceModel(title: "content"),
        ]
        data = [
            CollectListSectionModel(identifier: SectionType.userCard, items: cardList),
            CollectListSectionModel(identifier: SectionType.list, items: list),
            CollectListSectionModel(identifier: SectionType.reduce, items: reduceList)
        ]
    }
    
}
