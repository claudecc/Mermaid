//
//  CollectListViewController.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/21.
//  Copyright © 2022 claudechoi. All rights reserved.
//

// try this: https://medium.com/swift2go/implementing-a-dynamic-height-uicollectionviewcell-in-swift-5-bdd912acd5c8

import UIKit

class CollectListViewController: BaseVC, CollectCacheSize {
    private lazy var viewMoel = CollectListViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: flow)
        view.delegate = self
        view.dataSource = self
        view.register(cellType: CollectListCell.self)
        view.register(cellType: CollectListCardCell.self)
        view.register(cellType: CollectListReduceCell.self)
        return view
    }()
    
    private var data: [CollectListViewModel.Section] {
        get { viewMoel.data }
        set {
            viewMoel.data = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadData() {
        viewMoel.loadData()
    }
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
            
        case .reduce:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CollectListReduceCell.self)
            let model = sectionModel.items[indexPath.item] as! CollectReduceModel
            cell.update(model: model)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var sectionModel = data[indexPath.section]
        if sectionModel.identifier == .userCard {
            clearCellSize(indexPath: indexPath)
            var model = sectionModel.items[indexPath.item] as! CollectCardModel
            model.isFold.toggle()
            sectionModel.items[indexPath.item] = model
            data[indexPath.section] = sectionModel
            collectionView.reloadItems(at: [indexPath])
        }
    }
}

extension CollectListViewController: UICollectionViewDelegateFlowLayout {
    // collectionView roload时会把整个列表全load一遍
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionModel = data[indexPath.section]
        if sectionModel.identifier == .list {
            let width = floor(collectionView.frame.width / 3)
            return CGSize(width: width, height: 80)
        }
        let size = getCellSize(collectionView: collectionView, indexPath: indexPath)
        return size
    }
}
