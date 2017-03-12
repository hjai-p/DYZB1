//
//  CollectionNormalCell.swift
//  DouYuZB
//
//  Created by PH on 17/3/7.
//  Copyright © 2017年 HJ. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: CollectionBaseCell {
    
    // MARK: -控件属性
    /// 房间名称
    @IBOutlet weak var roomNameLabel: UILabel!
    
    // MARK: -定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            // 1 设置房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
