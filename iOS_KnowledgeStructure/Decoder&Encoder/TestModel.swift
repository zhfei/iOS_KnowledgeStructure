//
//  TestModel.swift
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/11/20.
//  Copyright © 2018年 zhf. All rights reserved.
//
//  swift 4.0 kvc 赋值失败问题
//  swift 4.0   kvc 赋值失败问题  需要在模型属性前加上 @objc ，以保证属性被添加到运行时方法列表

import UIKit

class TestModel: BaseModel {
    
     @objc var content: String = ""
     @objc var age: NSNumber = 10
     @objc var name: String = ""
     @objc var gender: NSNumber = 0
    
    init(content:String, age:NSNumber, name:String, gender: NSNumber = 0) {
        super.init()
        self.content = content
        self.age = age
        self.name = name
        self.gender = gender
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
    }
    
}
