//
//  CalendarListVC.swift
//  Mermaid
//
//  Created by caixiaodong on 2021/7/22.
//  Copyright © 2021 claudechoi. All rights reserved.
//

import UIKit

class CalendarListVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.rowHeight = 40
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var list = [
        ["title": "自定义", "type": 0],
        ["title": "HorizonCalendar", "type": 1],
        ["title": "CVCalendar", "type": 2]
    ] as [[String: Any]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") ?? UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = list[indexPath.row]["title"] as? String
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = list[indexPath.row]["type"] as? Int else {
            return
        }
        let calendarVC = CalendarVC(type: type)
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
}
