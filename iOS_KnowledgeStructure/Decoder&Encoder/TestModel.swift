//
//  TestModel.swift
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/11/20.
//  Copyright © 2018年 zhf. All rights reserved.
//

import UIKit

class TestModel: BaseModel {
    
     var content: String = ""
     var age: Int = 10
     var name: String = ""
     var gender: Bool = true
    
    init(content:String, age:Int, name:String, gender: Bool = true) {
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
