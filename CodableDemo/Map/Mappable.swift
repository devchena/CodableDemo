//
//  Mappable.swift
//  CodableDemo
//
//  Created by devchena on 2018/8/26.
//  Copyright © 2018年 devchena. All rights reserved.
//

import Foundation

public protocol Mappable: Codable {
    func modelMapFinished()
    mutating func structMapFinished()
}

extension Mappable {
    public func modelMapFinished() {

    }

    public func structMapFinished() {

    }
    
    public func toDict() -> [String: Any]? {
        let mirro = Mirror(reflecting: self)
        var dict = [String: Any]()
        for case let (key?, value) in mirro.children {
            dict[key] = value
        }

        if dict.isEmpty {
            print(MapError.modelToDictFail)
            return nil
        }
        
        return dict
    }
    
    public func toJSONString() -> String? {
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(self) {
            return String(data: jsonData, encoding: .utf8)
        }
        
        print(MapError.modelToJsonFail)
        return nil
    }
}
