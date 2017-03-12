//
//  AnchorModel.swift
//  DYZB1
//
//  Created by PH on 17/3/9.
//  Copyright © 2017年 HJ. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    /// 房间id
    var room_id : Int = 0
    
    /// 房间图片对应的URL
    var vertical_src : String = ""
    
    /// 判断是手机直播(1)还是电脑直播(0)
    var isVertical : Int = 0
    
    /// 房间名称
    var room_name : String = ""
    
    /// 昵称
    var nickname : String = ""
    
    /// 观看人数
    var online : Int = 0
    
    /// 所在城市
    var anchor_city : String = ""
    
    init(dict : [String : AnyObject]) {
        super.init() 
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
