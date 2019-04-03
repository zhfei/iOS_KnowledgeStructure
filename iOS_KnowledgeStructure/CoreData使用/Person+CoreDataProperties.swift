//
//  Person+CoreDataProperties.swift
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/4/3.
//  Copyright © 2019年 zhf. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: Int32
    @NSManaged public var name: String?
    @NSManaged public var card: Card?

}
