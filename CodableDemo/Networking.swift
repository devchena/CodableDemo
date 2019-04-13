//
//  Networking.swift
//  CodableAlamofireDemo
//
//  Created by user on 2018/8/17.
//  Copyright © 2018年 devchena. All rights reserved.
//

import Alamofire
import ObjectMapper

class Networking {

    class func request<T>(_ method: HTTPMethod = .get,
                          targetType: T,
                          url: URL,
                          parameters: [String: String],
                          success: @escaping (BaseResponse<T>) -> Void,
                          ret: @escaping (BaseResponse<T>) -> Void,
                          failure: @escaping (Error?) -> Void) where T: Any, T: Mappable {
        Alamofire.request(url,
                          method: method,
                          parameters: parameters)
        .responseJSON { (response) in
            switch response.result {
            case .success(let json):
                guard let json = json as? String else {
                    failure(nil)
                    return
                }

                if let response = BaseResponse<T>(JSONString: json) {
                    if response.code != 200 {
                        return failure(nil)
                    }

                    if response.ret != 100 {
                        return ret(response)
                    }

                    success(response)
                } else {
                    failure(nil)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
}
