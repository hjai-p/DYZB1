//
//  Date-Extension.swift
//  DYZB1
//
//  Created by PH on 17/3/9.
//  Copyright © 2017年 HJ. All rights reserved.
//

import UIKit

extension Date {
    static func getCurrentTime() -> String {
        let date = Date()
        let currentTime = Int(date.timeIntervalSince1970)
        return String(currentTime)
    }
}
