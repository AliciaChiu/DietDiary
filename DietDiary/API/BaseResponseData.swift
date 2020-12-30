//
//  BaseResponseData.swift
//  foodlist
//
//  Created by Aliicia on 2020/12/26.
//

import UIKit
import ObjectMapper

class BaseResponseData: Mappable {
    var status: String?
    var code: Int?
    var message: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        let length = map.JSON["error"].debugDescription.count > 1000 ? 1000 : map.JSON["error"].debugDescription.count
        print(map.JSON["error"].debugDescription.substring(to: length))
        
        
        status <- map["status"]
        code <- map["code"]
        message <- map["message"]
    }
}
