//
//  CollectionPrettyCell.swift
//  DouYuZB
//
//  Created by PH on 17/3/7.
//  Copyright © 2017年 HJ. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
    
    // MARK: - 控件属性
    /// 城市
    @IBOutlet weak var cityBtn: UIButton!

    // MARK: -定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            // 1 设置城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
