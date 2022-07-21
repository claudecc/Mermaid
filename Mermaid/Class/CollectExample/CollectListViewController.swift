//
//  CollectListViewController.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/21.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit

extension CollectListViewController {
    enum SectionType: Equatable {
        case userCard
        case reduce
        case list
    }
}

class CollectListViewController: BaseVC {
    private lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: flow)
        view.delegate = self
        view.dataSource = self
        view.register(cellType: CollectListCell.self)
        view.register(cellType: CollectListCardCell.self)
        return view
    }()
    
    typealias Section = CollectListSectionModel<SectionType, Any>
    private var data: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadData() {
        let list: [Any] = [
            CollectListModel(title: "item 1", des: "content"),
            CollectListModel(title: "item 2", des: "content"),
            CollectListModel(title: "item 3", des: "content"),
            CollectListModel(title: "item 4", des: "content"),
            CollectListModel(title: "item 5", des: "content"),
            CollectListModel(title: "item 6", des: "content"),
        ]
        data = [
            CollectListSectionModel(identifier: SectionType.userCard, items: [CollectCardModel(title: "UserName")]),
            CollectListSectionModel(identifier: SectionType.list, items: list)
        ]
    }
    
//    private func calculateCellSize() {
//
//    }
}

extension CollectListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        data.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data[section].items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionModel = data[indexPath.section]
        switch sectionModel.identifier {
        case .userCard:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CollectListCardCell.self)
            let model = sectionModel.items[indexPath.item] as! CollectCardModel
            cell.update(model: model)
            return cell
            
        case .list:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CollectListCell.self)
            let model = sectionModel.items[indexPath.item] as! CollectListModel
            cell.update(model: model)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

//extension CollectListViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        .zero
//    }
//}
