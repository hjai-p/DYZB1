//
//  ReCommendViewController.swift
//  DouYuZB
//
//  Created by PH on 17/3/6.
//  Copyright © 2017年 HJ. All rights reserved.
//

import UIKit

// MARK: -设置常量
private let kMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeadViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeadViewID = "kHeadViewID"

// MARK: -定义类
class ReCommendViewController: UIViewController {
    
    // MARK: -懒加载属性
    fileprivate lazy var recommendVM : ReCommendViewModel = ReCommendViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = kMargin
        layout.minimumLineSpacing = 0
//        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: kMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth] // 宽高随父控件自动拉伸
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadViewID)
        
        return collectionView
        
    }()

    // MARK: -系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK: -设置UI界面
        setupUI()
        
        // MARK: - 请求数据
        loadData()
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



// MARK: - 请求数据
extension ReCommendViewController {
    fileprivate func loadData() {
        recommendVM.requestData { 
            self.collectionView.reloadData()
        }
    }
}



// MARK: -设置UI界面
extension ReCommendViewController {
    func setupUI() {
        view.addSubview(collectionView)
    }
}



// MARK: -遵守UICollectionViewDataSource UICollectionViewDelegateFlowLayout协议
extension ReCommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1 取出模型
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        // 2 定义cell
        var cell : CollectionBaseCell!
        
        if indexPath.section == 1 {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        } else {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        
        // 给cell设置数据源
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewID, for: indexPath) as! CollectionHeadView
        
        headView.group = recommendVM.anchorGroups[indexPath.section]
                
        return headView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 { // 颜值cell
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
 }
