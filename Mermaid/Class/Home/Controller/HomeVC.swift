//
//  HomeVC.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2018/3/21.
//  Copyright © 2018年 蔡晓东. All rights reserved.
//

import UIKit
import PullToRefresh

class HomeVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    private var tableView : UITableView!
    private var listArray = [
        ["name": "banner", "vc": BannerVC.self],
        ["name": "segmentVC", "vc": SegmentVC.self],
        ["name": "瀑布流", "vc": BaseVC.self],
        ["name": "红包雨", "vc": BaseVC.self],
        ["name": "物理动画", "vc": BaseVC.self],
        ["name": "测试", "vc": TestVC.self],
        ["name": "日历", "vc": CalendarVC.self],
        ["name": "Difference", "vc": DifferenceViewController.self],
        ["name": "TableListViewController", "vc": TableListViewController.self],
        ["name": "CollectListViewController", "vc": CollectListViewController.self]
    ]
    
    deinit {
        tableView.removePullToRefresh(at: .top)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        
    }
    
    func setupUI() {
        tableView = UITableView(frame: self.view.frame, style: .plain)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        let refresher = PullToRefresh()
        weak var weakSelf = self
        tableView.addPullToRefresh(refresher) {
            DispatchQueue.global(qos: .default).asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                DispatchQueue.main.async {
                    weakSelf?.tableView.endRefreshing(at: .top)
                }
            })
//            DispatchQueue.global(qos: .default).async {
//                sleep(2)
//                DispatchQueue.main.async {
//                    weakSelf?.tableView.endRefreshing(at: .top)
//                }
//            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        let name = listArray[indexPath.row]["name"] as? String
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
//            XDDownloadImageManager.test()
//            XDArrayTool.test()
//            TestJsonModelTool.testJsonToModel()
            let test = PriceRangeView(minValue: 18, maxValue: 30.6)
            test.calculate()
            return
        }
        guard let vcClass = listArray[indexPath.row]["vc"] as? BaseVC.Type else {
            return
        }
        let vc:BaseVC = vcClass.init()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
