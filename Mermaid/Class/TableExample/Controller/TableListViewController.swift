//
//  TableListViewController.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/21.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit

class TableListViewController: BaseVC, TableCacheHeight {
    private lazy var viewModel = TableListViewModel()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.register(cellType: TableListUserCell.self)
        view.register(cellType: TableListCell.self)
        view.register(cellType: TableListCardCell.self)
        return view
    }()
    
    private var data: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        viewModel.loadData()
    }
}

extension TableListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data[section].items.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getCellHeight(tableView: tableView, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = viewModel.data[indexPath.section]
        switch sectionModel.identifier {
        case .user:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TableListUserCell.self)
            let model = sectionModel.items[indexPath.row] as! TableListUserModel
            cell.update(model: model)
            return cell
            
        case .list:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TableListCell.self)
            let model = sectionModel.items[indexPath.row] as! TableListModel
            cell.update(model: model)
            return cell
            
        case .card:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TableListCardCell.self)
            let model = sectionModel.items[indexPath.row] as! TableListCardModel
            cell.update(model: model)
            return cell
        }
    }
}
