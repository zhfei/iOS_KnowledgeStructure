//
//  GeneralModel.swift
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2018/11/21.
//  Copyright © 2018年 zhf. All rights reserved.
//

import UIKit

class GeneralModel: NSObject, NSCoding {
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
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(content, forKey: "content")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(gender, forKey: "gender")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.content = aDecoder.decodeObject(forKey: "content") as! String
        self.age = aDecoder.decodeObject(forKey: "age") as! Int
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.gender = aDecoder.decodeBool(forKey: "gender")
    }
}
