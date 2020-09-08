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
    private var listArray : NSMutableArray!
    
    deinit {
        tableView.removePullToRefresh(at: .top)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        
    }
    
    func setupUI() {
        listArray = NSMutableArray(array: [["name":"banner","vc":"BannerVC"],["name":"segmentVC","vc":"SegmentVC"],["name":"瀑布流","vc":""],["name":"红包雨","vc":""],["name":"物理动画","vc":""],["name":"测试","vc":"TestVC"]])
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
        let dict:NSDictionary = self.listArray.object(at: indexPath.row) as! NSDictionary
        cell.textLabel?.text = dict.object(forKey: "name") as? String
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
        let dict:NSDictionary = self.listArray.object(at: indexPath.row) as! NSDictionary
        let vcName = dict.object(forKey: "vc") as! String
        if vcName.isEmpty {
            return
        }
        let vcClass = NSClassFromString("SwiftLearning."+vcName) as! BaseVC.Type
        let vc:BaseVC = vcClass.init()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
