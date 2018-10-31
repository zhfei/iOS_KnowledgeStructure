//
//  MainTableCoordinater.swift
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/10/31.
//  Copyright © 2018年 zhf. All rights reserved.
//

import UIKit

class MainTableCoordinater: NSObject {
    var storyBoardNav: UINavigationController?
    init(_ storyBoardNav: UINavigationController) {
        self.storyBoardNav = storyBoardNav
    }
    
    func pushStoryBoardVC(_ storyBoardID: String) {
        let target = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyBoardID)
        storyBoardNav?.pushViewController(target, animated: true)
    }
}
