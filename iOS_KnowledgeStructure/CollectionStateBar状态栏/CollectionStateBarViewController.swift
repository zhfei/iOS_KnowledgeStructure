//
//  CollectionStateBarViewController.swift
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/8/27.
//  Copyright © 2019年 zhf. All rights reserved.
//

import UIKit

class CollectionStateBarViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        
        
        let frame = CGRect.init(x: 0, y: 100, width: 300, height: 100);
        let collectV = UICollectionView.init(frame: frame, collectionViewLayout: layout);
        collectV.delegate = self;
        collectV.dataSource = self;
        collectV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell");
    }
    
    
}

extension CollectionStateBarViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        return cell;
    }

}
