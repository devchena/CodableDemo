//
//  ViewController.swift
//  CodableDemo
//
//  Created by devchena on 2018/8/20.
//  Copyright © 2018年 devchena. All rights reserved.
//

import UIKit

struct GuideModel: Mappable {
    var step: String?
    var text_list = GuideTextModel()
    var link_img = ""
    var amount = "0"
    var wb = "0"
    var text_number = ""

    struct GuideTextModel: Mappable {
        var line1 = ""
        var button1 : String?
        var button2 : String?
        var button3 : String?
    }
}

class ViewController: UIViewController {

    let dict: [String: Any] = [
        "step":NSNull(),
        "text_list":["line1":"完成新手任务还可获得更多现金红包",
                     "button1":"去完成任务",
                     "button2":"去完成任务",
                     "button3":"去完成任务"],
        "link_img":"",
        "amount":"0.5",
        "wb":"5",
        "text_number":"4"
    ]
    
    let dicts: [[String: Any]] = [
        [
            "step":"1",
            "text_list":["line1":"完成新手任务还可获得更多现金红包111",
                         "button1":"去完成任务",
                         "button2":"去完成任务",
                         "button3":"去完成任务"],
            "link_img":"",
            "amount":"0.5",
            "wb":"5",
            "text_number":"4"
        ],
        [
            "step":"2",
            "text_list":["line1":"完成新手任务还可获得更多现金红包222",
                         "button1":"去完成任务",
                         "button2":"去完成任务",
                         "button3":"去完成任务"],
            "link_img":"",
            "amount":"1.5",
            "wb":"5",
            "text_number":"4"
        ],
        [
            "step":"3",
            "text_list":["line1":"完成新手任务还可获得更多现金红包333",
                         "button1":"去完成任务",
                         "button2":"去完成任务",
                         "button3":"去完成任务"],
            "link_img":"",
            "amount":"2.5",
            "wb":"5",
            "text_number":"4"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(Date())
        
        if let model = try? Mapper.mapFromDict(dict, GuideModel.self) {
            print("model.amount:" + model.amount)
            print("model.toDict:" + String(describing: model.toDict()))
            print("model.toJSONString:" + String(describing: model.toJSONString()))
        }
        
//        print("dict.toJSONString:\(String(describing: dict.toJSONString()))")
//
//        if let jsonString = dict.toJSONString() {
//            if let model = try? Mapper.mapFromJSON(jsonString, GuideModel.self) {
//                print(model)
//            }
//        }
//
        if let models = try? dicts.mapFromJSON([GuideModel].self) {
            print("models:\(models)")
        }
//
//        print(Date())
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

