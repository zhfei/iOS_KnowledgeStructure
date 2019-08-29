//
//  CollectionStateBarViewController.swift
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/8/27.
//  Copyright © 2019年 zhf. All rights reserved.
//

import UIKit

class CollectionStateBarViewController: UIViewController {
    
    var collectionView: UICollectionView?
    let Identifier = "CollectionViewCell"
    let headerIdentifier = "UICollectionElementKindSectionFooter"
    let footIdentifier = "UICollectionElementKindSectionFooter"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        let widthS = UIScreen.main.bounds.size.width

        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        // 设置分区头视图和尾视图宽高
        layout.headerReferenceSize = CGSize.init(width: widthS, height: 80)
        layout.footerReferenceSize = CGSize.init(width: widthS, height: 80)
        
        
        collectionView = UICollectionView.init(frame: CGRect(x:0, y:64, width:widthS, height:400), collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell");
        self.view.addSubview(collectionView!)

        
        // 注册cell
        collectionView?.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Identifier)

    }
    
    
}

extension CollectionStateBarViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath)
        cell.backgroundColor = armColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func armColor()->UIColor{
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

}
