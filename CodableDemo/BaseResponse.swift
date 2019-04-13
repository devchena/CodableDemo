//
//  BaseResponse.swift
//  CodableAlamofireDemo
//
//  Created by user on 2018/8/18.
//  Copyright © 2018年 devchena. All rights reserved.
//

import ObjectMapper

struct BaseResponse<T: Mappable>: Mappable {
    var code: Int = 0
    var ret: Int = 0
    var totalCount: Int = 0
    var message: String?
    var result: [T] = []

    private var list: [T] = []
    private var detail: [T] = []
    private var body: [T] = []

    init?(map: Map) {
        
    }

    mutating func mapping(map: Map) {
        code        <- map["code"]
        ret         <- map["results.ret"]
        totalCount  <- map["results.totalCount"]
        message     <- map["results.msg"]
        list        <- map["results.list"]
        detail      <- map["results.detail"]
        body        <- map["results.body"]

        result = list + detail + body
    }
}
