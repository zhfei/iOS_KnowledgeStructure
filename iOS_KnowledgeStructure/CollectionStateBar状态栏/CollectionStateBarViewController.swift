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
    let Identifier = "UICollectionViewCell"
    let headerIdentifier = "UICollectionElementKindSectionFooter"
    let footIdentifier = "UICollectionElementKindSectionFooter"
    
    var currentIndexPath: IndexPath?
    
    
    lazy var myTimer: Timer = {
        return Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            print("打印...")
            self.currentIndexPath = IndexPath(item: (self.currentIndexPath?.row)!+1, section: 0);
            self.collectionView?.scrollToItem(at: self.currentIndexPath!, at: UICollectionViewScrollPosition.centeredVertically, animated: true);
        })
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.myTimer.invalidate();
    }
    
    func setupUI() {
        let widthS = UIScreen.main.bounds.size.width
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: widthS, height: 80)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
//        // 设置分区头视图和尾视图宽高
//        layout.headerReferenceSize = CGSize.init(width: widthS, height: 80)
//        layout.footerReferenceSize = CGSize.init(width: widthS, height: 80)
        
        
        collectionView = UICollectionView.init(frame: CGRect(x:0, y:100, width:widthS, height:100), collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.lightGray
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell");
        self.view.addSubview(collectionView!)
        
        
        currentIndexPath = IndexPath(row: 0, section: 0);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        _ = self.myTimer
    }
    
}

extension CollectionStateBarViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
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
