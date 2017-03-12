//
//  CollectionBaseCell.swift
//  DYZB1
//
//  Created by PH on 17/3/10.
//  Copyright © 2017年 HJ. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    /// 图片
    @IBOutlet weak var iconImageView: UIImageView!
    /// 昵称
    @IBOutlet weak var nicknameLabel: UILabel!
    /// 在线人数
    @IBOutlet weak var onlineBtn: UIButton!
    
    // MARK: - 模型属性
    var anchor : AnchorModel? {
        didSet {
            // 1 校验模型是否有值
            guard let anchor = anchor else { return }
            
            // 2 设置昵称
            nicknameLabel.text = anchor.nickname
            
            // 3 设置在线人数
            var onlineStr = ""
            if anchor.online >= 10000 {
                onlineStr = String(Double(anchor.online / 10000)) + "万在线"
            } else {
                onlineStr = String(Int(anchor.online)) + "在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            // 4 设置图片
            iconImageView.kf.setImage(with: URL(string: anchor.vertical_src))
        }
    }
}
