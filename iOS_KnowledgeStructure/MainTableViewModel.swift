//
//  MainTableViewModel.swift
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/10/31.
//  Copyright © 2018年 zhf. All rights reserved.
//

import UIKit

class MainTableViewModel: NSObject {

    var dataSource:[String] = ["多线程技术","自动归档解归档","混合编程","自定义弹窗UIWindow","字符串引用计数","未知消息发送","事件传输链和响应链","定位功能","照片的保存和访问","ScrollView的应用","Runloop的应用","自定义NavigationBar","数组过滤","生命周期","省市区街道选择","CoreText_CoreImage","八种多线程锁","人工智能","本地通知","CoreData使用","富文本","EmptyView占位视图","手码布局","搜索控制器","网络请求","模拟服务器"]
    static let shared = MainTableViewModel()

}
