//
//  CollectionHeadView.swift
//  DouYuZB
//
//  Created by PH on 17/3/6.
//  Copyright © 2017年 HJ. All rights reserved.
//

import UIKit

class CollectionHeadView: UICollectionReusableView {
    // MARK: -控件属性
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    // MARK: -定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
