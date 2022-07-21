//
//  DifferenceViewController.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/21.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit
import DifferenceKit

class DifferenceViewController: BaseVC {

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.register(cellType: DifferenceListCell.self)
        return view
    }()
    
    private var _data: [DifferenceListModel] = [
        DifferenceListModel(id: 0, name: "0"),
        DifferenceListModel(id: 1, name: "1"),
        DifferenceListModel(id: 2, name: "2"),
        DifferenceListModel(id: 3, name: "3"),
    ]
    private var data: [DifferenceListModel] {
        get {
            _data
        }
        set {
            let changeset = StagedChangeset(source: _data, target: newValue)
            tableView.reload(using: changeset, with: .fade) { [weak self] data in
                guard let self = self else { return }
                self._data = data
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
    }
    
    @objc
    private func refresh() {
        let id = data.last!.id
        let newList = (id...id + 4).map({ DifferenceListModel(id: $0, name: "\($0)") })
        data = data + newList
    }
}

extension DifferenceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DifferenceListCell.self)
        cell.textLabel?.text = data[indexPath.row].name
        return cell
    }
}
