//
//  MapExtensions.swift
//  CodableDemo
//
//  Created by devchena on 2018/8/26.
//  Copyright © 2018年 devchena. All rights reserved.
//

import Foundation

extension Array {
    public func toJSONString(_ options: JSONSerialization.WritingOptions = []) -> String? {
        if JSONSerialization.isValidJSONObject(self) {
            if let newData = try? JSONSerialization.data(withJSONObject: self, options: options) {
                let jsonString = String(data: newData, encoding: .utf8)
                return jsonString?.replacingOccurrences(of: "null", with: "\"\"")
            }
        }
        
        print(MapError.arrayToJsonFail)
        return nil
    }
    
    public func mapFromJSON<T: Decodable>(_ type: [T].Type) throws -> Array<T> {
        guard let jsonString = toJSONString() else {
            print(MapError.arrayToJsonFail)
            throw MapError.arrayToJsonFail
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            print(MapError.jsonToDataFail)
            throw MapError.jsonToDataFail
        }
        
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode(type, from: jsonData) {
            return obj
        }
        
        print(MapError.jsonToArrayFail)
        throw MapError.jsonToArrayFail
    }
}

extension Dictionary {
    public func toJSONString(_ options: JSONSerialization.WritingOptions = []) -> String? {
        if JSONSerialization.isValidJSONObject(self) {
            if let newData = try? JSONSerialization.data(withJSONObject: self, options: options) {
                let jsonString = String(data: newData, encoding: .utf8)
                return jsonString?.replacingOccurrences(of: "null", with: "\"\"")
            }
        }
        
        print(MapError.dictToJsonFail)
        return nil
    }
}

extension String {
    public func toDict(_ options: JSONSerialization.ReadingOptions = []) -> [String: Any]? {
        guard let jsonData = data(using: .utf8) else {
            print(MapError.jsonToDataFail)
            return nil
        }
        
        if let dict = try? JSONSerialization.jsonObject(with: jsonData, options: options) as? [String: Any] {
            return dict
        }
        
        print(MapError.jsonToDictFail)
        return nil
    }
}

