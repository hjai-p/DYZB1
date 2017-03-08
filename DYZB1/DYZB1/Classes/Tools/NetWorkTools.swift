
//
//  NetWorkTools.swift
//  DouYuZB
//
//  Created by PH on 17/3/8.
//  Copyright © 2017年 HJ. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetWorkTools {
    // MARK: - 发送网络请求的方法
    class public func requestData(type: MethodType, URLString: String, parameters: [String : String]? = nil, finishedCallback: @escaping (_ result: AnyObject) -> ()) {
        // 1 获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        // 2 发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            // 3 获取结果
            guard let result = response.result.value else {
                print(response.result.error ?? "获取结果失败")
                return
            }
            
            // 4 将结果回调出去
            finishedCallback(result as AnyObject)
        }
    }
}
