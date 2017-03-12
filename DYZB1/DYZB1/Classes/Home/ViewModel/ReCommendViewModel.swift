//
//  ReCommendViewModel.swift
//  DYZB1
//
//  Created by PH on 17/3/9.
//  Copyright © 2017年 HJ. All rights reserved.
//

import UIKit

class ReCommendViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    fileprivate lazy var bigDataGroups : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroups : AnchorGroup = AnchorGroup()
}



// MARK: - 请求数据
/*
    网络请求时异步进行的，所以请求回来的数据的顺序并不能确定。
    使用 DispatchGroup 可以保证在全部请求完成之后按顺序拼接数据
 */
extension ReCommendViewModel {
    func requestData(finishedCallback: @escaping () -> () ) {
        // 1 定义请求参数
        let parameters = ["limit":"4", "offset":"0", "time":Date.getCurrentTime()]
        
        // 2 创建
        let disGroup = DispatchGroup()
        
        // 3 请求推荐数据
        // 进入组
        disGroup.enter()
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": Date.getCurrentTime() ], finishedCallback: { (result) in
            // 1 将result转化为字典
            guard let resultDict = result as? [String : AnyObject] else { return }
            
            // 2 根据data这个key获取数组
            guard let dataArr = resultDict["data"] as? [[String : AnyObject]] else { return }
            
            // 3 遍历数组获取字典，并将字典转化为模型
            // 3.1 设置组的属性
            self.bigDataGroups.tag_name = "热门"
            self.bigDataGroups.icon_name = "home_header_hot"
            
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroups.anchors.append(anchor)
            }
            
            // 3.2 离开组
            disGroup.leave()
        })
        
        // 4 请求颜值数据
        disGroup.enter()
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters, finishedCallback: { (result) in
            // 1 将result转化为字典
            guard let resultDict = result as? [String : AnyObject] else { return }
            
            // 2 根据data这个key获取数组
            guard let dataArr = resultDict["data"] as? [[String : AnyObject]] else { return }
            
            // 3 遍历数组获取字典，并将字典转化为模型
            
            // 3.1 设置组的属性
            self.prettyGroups.tag_name = "颜值"
            self.prettyGroups.icon_name = "home_header_phone"
            
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroups.anchors.append(anchor)
            }
            disGroup.leave()
        })
        
        
        // 5 请求游戏数据
        disGroup.enter()
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit:4&offset:0&time:1489028933
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters, finishedCallback: { (result) in
            // 1 将result转化为字典
            guard let resultDict = result as? [String : AnyObject] else { return }
            
            // 2 根据data这个key获取数组
            guard let dataArr = resultDict["data"] as? [[String : AnyObject]] else { return }
            
            // 3 遍历数组获取字典，并将字典转化为模型
            for dict in dataArr {
                let dataModel = AnchorGroup(dict: dict)
                self.anchorGroups.append(dataModel)
            }
            disGroup.leave()
        })
        
        disGroup.notify(queue: DispatchQueue.main, execute: {
            // 拼接数据
            self.anchorGroups.insert(self.prettyGroups, at: 0)
            self.anchorGroups.insert(self.bigDataGroups, at: 0)
            finishedCallback()
        })
    }
}
 
