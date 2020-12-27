//
//  CategoriesData.swift
//  foodlist
//
//  Created by Alicia on 2020/12/26.
//

import UIKit
import ObjectMapper

class CategoriesData: BaseResponseData {
    var data: [Category]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

class Category: Mappable {
    var category_name: String?
    var id: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        category_name <- map["category_name"]
    }
}
