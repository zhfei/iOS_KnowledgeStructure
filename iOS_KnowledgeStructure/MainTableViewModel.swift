//
//  MainTableViewModel.swift
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/10/31.
//  Copyright © 2018年 zhf. All rights reserved.
//

import UIKit

class MainTableViewModel: NSObject {

    var dataSource:[String] = ["多线程技术","自动归档解归档","混合编程","自定义弹窗UIWindow","字符串引用计数","未知消息发送","事件传输链和响应链","定位功能","照片的保存和访问","ScrollView的应用"]
    static let shared = MainTableViewModel()

}
