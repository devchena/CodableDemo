//
//  Mapper.swift
//  CodableDemo
//
//  Created by devchena on 2018/8/26.
//  Copyright © 2018年 devchena. All rights reserved.
//

import Foundation

public enum MapError: Error {
    case jsonToModelFail    // json转model失败
    case jsonToDataFail     // json转data失败
    case jsonToArrayFail    // json转数组失败
    case jsonToDictFail     // json转字典失败
    case dictToJsonFail     // 字典转json失败
    case arrayToJsonFail    // 数组转json失败
    case modelToJsonFail    // model转json失败
    case modelToDictFail    // model转字典失败
}

public class Mapper {
    /// 字典转模型
    public class func mapFromDict<T: Mappable>(_ dict: [String: Any], _ type: T.Type) throws -> T {
        guard let jsonString = dict.toJSONString() else {
            print(MapError.dictToJsonFail)
            throw MapError.dictToJsonFail
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            print(MapError.jsonToDataFail)
            throw MapError.jsonToDataFail
        }
        
        do {
            let decoder = JSONDecoder()
            var obj = try decoder.decode(type, from: jsonData)
            let mirro = Mirror(reflecting: obj)
            if mirro.displayStyle == Mirror.DisplayStyle.struct {
                obj.structMapFinished()
            }
            if mirro.displayStyle == Mirror.DisplayStyle.class {
                obj.modelMapFinished()
            }
            return obj
        } catch {
            print("mapFromDict failed: " + error.localizedDescription)
            throw MapError.jsonToModelFail
        }
    }
    
    /// json转模型
    public class func mapFromJSON<T: Mappable>(_ jsonString: String, _ type: T.Type) throws -> T {
        guard let jsonData = jsonString.data(using: .utf8) else {
            print(MapError.jsonToDataFail)
            throw MapError.jsonToDataFail
        }
        
        do {
            let decoder = JSONDecoder()
            var obj = try decoder.decode(type, from: jsonData)
            let mirro = Mirror(reflecting: obj)
            if mirro.displayStyle == Mirror.DisplayStyle.struct {
                obj.structMapFinished()
            }
            if mirro.displayStyle == Mirror.DisplayStyle.class {
                obj.modelMapFinished()
            }
            return obj
        } catch {
            print("mapFromJSON failed: " + error.localizedDescription)
            throw MapError.jsonToModelFail
        }
    }
}
