//
//  MeVC.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2018/3/21.
//  Copyright © 2018年 蔡晓东. All rights reserved.
//

import UIKit

class MeVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    private var tableView : UITableView!
    private var listArray : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func setupUI() {
        self.view.backgroundColor = UIColor.brown
        listArray = ["1","2","3","4","5","6","7","8","9","10"]
        tableView = UITableView(frame: self.view.frame, style: .plain)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.tableHeaderView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "第\(indexPath.row)行"
        return cell
    }
    
    
    
}
