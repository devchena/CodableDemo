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

public class Mapper<T: Mappable> {
    public class func mapFromDict(_ dict: [String: Any]) throws -> T {
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
            var obj = try decoder.decode(T.self, from: jsonData)
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
    
    public class func mapFromJSON(_ jsonString: String) throws -> T {
        guard let jsonData = jsonString.data(using: .utf8) else {
            print(MapError.jsonToDataFail)
            throw MapError.jsonToDataFail
        }
        
        do {
            let decoder = JSONDecoder()
            var obj = try decoder.decode(T.self, from: jsonData)
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

    public class func mapFromJSONObject(_ jsonObject: Any) throws -> T {
        if let jsonString = jsonObject as? String {
            do {
                let obj = try mapFromJSON(jsonString)
                return obj
            } catch let error {
                throw error
            }
        } else if let dict = jsonObject as? [String: Any] {
            do {
                let obj = try mapFromDict(dict)
                return obj
            } catch let error {
                throw error
            }
        }

        throw MapError.jsonToModelFail
    }

    /// 数组转模型
    public class func mapFromArray(_ array: [Any]) throws -> [T] {
        do {
            let objs = try array.map([T].self)
            return objs
        } catch let error {
            print("mapFromArray failed: " + error.localizedDescription)
            throw error
        }
    }
}
