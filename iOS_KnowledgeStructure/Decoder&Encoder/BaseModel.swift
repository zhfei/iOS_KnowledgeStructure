//
//  BaseModel.swift
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/11/20.
//  Copyright © 2018年 zhf. All rights reserved.
//

import UIKit


class BaseModel: NSObject, NSCoding {
    override init() {}
    
    func getPropertyNameList()->[String]{  //和description属性一样
        var selfProperties = [String]()
        var count:UInt32 =  0
        let vars = class_copyIvarList(type(of: self), &count)
        for i in 0..<count {
            let t = ivar_getName((vars?[Int(i)])!)
            if let n = NSString(cString: t!, encoding: String.Encoding.utf8.rawValue) as String?
            {
                selfProperties.append(n)
            }
        }
        free(vars)
        return selfProperties
    }
    
    
    /// 协议方法
    ///
    /// - Parameter aCoder: 编码
    func encode(with aCoder: NSCoder) {
        let propertyList = getPropertyNameList()
        for p_name in propertyList {
            aCoder.encode(value(forKey: p_name), forKey: p_name)
        }
        print("encode successful")
    }
    
    /// 协议方法
    ///
    /// - Parameter aDecoder: 解码
    required init?(coder aDecoder: NSCoder) {
        super.init()
        let propertyList = getPropertyNameList()
        for p_name in propertyList {
            let value = aDecoder.decodeObject(forKey: p_name)
            setValue(value, forKey: p_name)
        }
    }
    
    
    /// 实例方法，开始编码
    ///
    /// - Parameter fileName: 文件名字
    func archive(fileName: String) {
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let savePath = filePath + "/" + fileName + ".plist"
        NSKeyedArchiver.archiveRootObject(self, toFile: savePath)
    }
    
    /// 类方法，开始解码
    ///
    /// - Parameter fileName: 文件名字
    /// - Return: 返回一个实例，可以为空
    static func unarchive(fileName: String) -> Any? {
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let savePath = filePath + "/" + fileName + ".plist"
        return NSKeyedUnarchiver.unarchiveObject(withFile: savePath)
    }
}


