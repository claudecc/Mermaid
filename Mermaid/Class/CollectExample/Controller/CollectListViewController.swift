//
//  CollectListViewController.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/21.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit

class CollectListViewController: BaseVC {
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
    
    /// 需要先在cellForItemAt中赋值数据
    private func calculateCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        var width: CGFloat = collectionView.frame.width
        let calculateCell = self.collectionView(collectionView, cellForItemAt: indexPath)
        if calculateCell is CollectListCell {
            width = floor(collectionView.frame.width / 3)
            return CGSize(width: width, height: 80)
        }
        let maxSize = CGSize(width: width, height: collectionView.frame.height)
        let size = calculateCell.contentView.systemLayoutSizeFitting(maxSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return size
    }
}

extension CollectListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewMoel.data.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewMoel.data[section].items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionModel = viewMoel.data[indexPath.section]
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
}

extension CollectListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = calculateCellSize(collectionView: collectionView, indexPath: indexPath)
        XDLog.log("indexPath: \(indexPath.section):\(indexPath.row)")
        return size
    }
}
