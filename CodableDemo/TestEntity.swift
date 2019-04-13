//
//  TestEntity.swift
//  QingkCloud_Swift
//
//  Created by user on 2018/8/18.
//

import ObjectMapper

struct TestEntity: Mappable {
    var activityId = ""
    var title = ""
    var flagImg = ""
    var isUsedImg = ""
    var shareContent = ""

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        activityId      <- map["activityId"]
        title           <- map["title"]
        flagImg         <- map["flagImg"]
        isUsedImg       <- map["isUsedImg"]
        shareContent    <- map["shareContent"]
    }
}


