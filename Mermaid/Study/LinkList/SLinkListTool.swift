//
//  SLinkListTool.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2020/5/24.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

import UIKit

struct SNode {
    var data:AnyObject?
    var next:AnyObject?
}

class SLinkListTool: NSObject {
    
    func test() {
        
    }
    
//    func getLongList() -> Array {
//        var array = Array()
//        array.append
//    }
    
}

/*
 给定两个单链表，编写算法找出两个链表的公共结点
 
 算法思想：两个链表有公共结点的话，那么从第一个公共结点开始，后面的结点都是相同的，不可
 能出现分叉。又由于两个链表的长度不一定一样，故不能同时遍历两个链表。
 可以先得到两个链表的长度l1,l2,设l1-l2=k,那么在教长的链表上遍历k个结点，在同步遍历两个链
 表，保证两个链表同时到达最后一个节点，这样也就保证了能够同时到达第一个公共结点。
 
 
 
 1.获取两个链表长度
 2.获取两个链表的差值，获取他们的next
 3.while循环差值到0，更新长链的下一个
 
 
 1 2 3 4 5 6 7 8
 3 4 5
 
 
 
 
 */
