//
//  PostData.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2021/4/3.
//

import Foundation
import ObjectMapper

class PostData: BaseResponseData {
    var data: [Post]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

class Post: Mappable {

    var post_count: Int?
    var date: String?

    required init?(map: Map) {}
    required init() {}
    
    func mapping(map: Map) {

        post_count <- map["post_count"]
        date <- map["date"]
    }
}
