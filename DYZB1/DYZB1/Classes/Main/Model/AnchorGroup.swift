//
//  AnchorGroup.swift
//  DYZB1
//
//  Created by PH on 17/3/9.
//  Copyright © 2017年 HJ. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    /// 该组中的房间信息
    var room_list : [[String : AnyObject]]? {   // 属性监听器
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    /// 组显示的标题
    
    // lllllllllllllllllll
    var tag_name : String = ""  /// 啦啦啦啦啦啦啦啦啦
    
    /// 组显示的图片
    var icon_name : String = "home_header_normal"
    
    /// 主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    // MARK: -重写构造函数
    override init() {
        super.init()
    }
    
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    /*
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : AnyObject]] {
                for dict in dataArray {
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    } */
}
