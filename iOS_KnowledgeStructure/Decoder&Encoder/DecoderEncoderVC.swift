//
//  DecoderEncoderVC.swift
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/11/20.
//  Copyright © 2018年 zhf. All rights reserved.
//

import UIKit

class DecoderEncoderVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let model =  CoderModel(name: "jack", age: 10, sex: "男")
        let data = NSKeyedArchiver.archivedData(withRootObject: model)
        let model1 = NSKeyedUnarchiver.unarchiveObject(with: data) as! CoderModel
        
        print("model1:\(model1)")
//        let model = TestModel(content: "内容", age: 18, name: "姓名")
//        model.archive(fileName: "test1")
//        let modd = TestModel.unarchive(fileName: "test1")
//
//        print("modd: \(modd)")
        
//        let model = GeneralModel(content: "内容", age: 18, name: "姓名")
//
//       let data = try!  NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false)
//       let reslt = try!  NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
//
//        print("modd: \(data)")
    }

}
